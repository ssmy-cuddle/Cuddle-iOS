//
//  OAuthRequestInterceptor.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

import Alamofire
import UIKit

enum OauthInterceptorError: Error {
    case unowned
}

final class OAuthRequestInterceptor: RequestInterceptor {
    private typealias RefreshCompletion = (_ accessToken: String?, _ refreshToken: String?) -> Void
//
//    private let tokenLayer: OAuthTokenLayer
    private let tokenValidator = JWTTokenValidator()
//    private let accessTokenRefresher: AccessTokenRefresher
//    private let requestFailRequestHandler: RequestFailureHandler?
//    
//    private let

    private let lock = NSRecursiveLock()
    private var isRefreshing = false

    private var requestsToRetry: [Request] = []
    private var requestCompletionBlocksToRetry: [(RetryResult) -> Void] = []

    private var maxRetryCount: Int = 3
    private var lastRetryDate: Date?
    
    

    // MARK: - Initialization

    public init() {
//        self.tokenLayer = tokenLayer
//        self.tokenValidator = tokenValidator
//        self.accessTokenRefresher = accessTokenRefresher
//        self.requestFailRequestHandler = requestFailRequestHandler
    }

    // MARK: - Adaptor

    func adapt(_ urlRequest: URLRequest, for _: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest

        guard let accessToken = KeyChainStorage.shared.loadToken(forKey: "accessToken"), !accessToken.isEmpty else {
            completion(.failure(OauthInterceptorError.unowned))
            return
        }

        guard tokenValidator.isTokenValid(accessToken) else {
            // token expired
            completion(.failure(OauthInterceptorError.unowned))
            return
        }

        // MARK: - Authorization
        urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }

    // MARK: - Retrier

    func retry(_ request: Request, for _: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock()
        defer { lock.unlock() }

        // If retry failed for maxRetryCount times, do not retry
        guard request.retryCount <= maxRetryCount else {
            if [
                NSURLErrorCannotConnectToHost,
                NSURLErrorTimedOut,
                NSURLErrorNetworkConnectionLost,
                NSURLErrorNotConnectedToInternet
            ].contains((error as NSError).code) {}
            completion(.doNotRetry)
            return
        }

        let error: Error = {
            switch error {
            case let AFError.requestAdaptationFailed(error):
                return error
            default:
                return error
            }
        }()

        if request.response?.statusCode == 401 {
            guard let refreshToken = KeyChainStorage.shared.loadToken(forKey: "refreshToken"),
                  tokenValidator.isTokenValid(refreshToken)
            else {
                completion(.doNotRetry)
                reauthFailed()
                return
            }

            if lastRetryDate == nil {
                lastRetryDate = Date()
            }
            // Store Requests and CompletionBlocks
            if let date = lastRetryDate, Date().timeIntervalSince(date) < 30 {
                requestsToRetry.append(request)
            }
            requestCompletionBlocksToRetry.append(completion)

            // Only perform refresh when no refreshing is running
            if !isRefreshing {
                refreshTokens(refreshToken: refreshToken) {
                    [weak self] accessToken, refreshToken in
                    guard let self = self else { return }
                    self.lock.lock()
                    var succeed: Bool = false
                    if let accessToken = accessToken, let refreshToken = refreshToken {
                        let _ = KeyChainStorage.shared.saveToken(accessToken, forKey: "accessToken")
                        let _ = KeyChainStorage.shared.saveToken(refreshToken, forKey: "refreshToken")
                        succeed = true
                    } else {
                        succeed = false
                    }
                    
                    self.requestsToRetry.removeAll()
                    self.requestCompletionBlocksToRetry.forEach { $0(.retry) }
                    self.requestCompletionBlocksToRetry.removeAll()
                    self.lastRetryDate = nil

                    // Unlock
                    self.lock.unlock()

                    // If failed, go to login view
                    if !succeed {
                        self.reauthFailed()
                    }
                }
            }
        } else {
            if [NSURLErrorCannotConnectToHost, NSURLErrorTimedOut, NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet].contains((error as NSError).code) {
                // Network Error
                // Retry after 0.5s
                completion(.retryWithDelay(0.5))
            } else {
                // Fail request
                completion(.doNotRetry)
            }
        }
    }
    
    private func reauthFailed() {
        NotificationCenter.default.post(name: Notification.Name("AuthorizationFailed"), object: nil)
    }

    // MARK: - Private - Refresh Tokens

    private func refreshTokens(refreshToken: String, completion: @escaping RefreshCompletion) {
        guard !isRefreshing else { return }
        isRefreshing = true
        AccessTokenRefresher()
            .refreshToken(refreshToken: "") { [weak self] accessToken, refreshToken in
                completion(accessToken, refreshToken)
                self?.isRefreshing = false
            }
    }
}

public class JWTTokenValidator {
    public init() {}

    public func isTokenValid(_ token: String) -> Bool {
        let args = token.components(separatedBy: ".")

        let payload = args[1]
        // Swift Data base64 decode에서는 encoded String의 길이가 4의 배수일 떄에만 파싱이 가능함.
        // encoded string이 4의 배수가 아닐 때에는, 4의 배수가 되도록 뒤에 padding character(=) 를 넣어줘야 제대로 파싱이 가능
        let remainder = payload.count % 4
        var encodedStr = payload
        if remainder > 0 {
            encodedStr = payload.padding(
                toLength: encodedStr.count + 4 - remainder,
                withPad: "=",
                startingAt: 0
            )
        }
        guard let decodedData = Data(base64Encoded: encodedStr, options: .ignoreUnknownCharacters) else {
            return false
        }
        do {
            if let jsonObject = try JSONSerialization.jsonObject(
                with: decodedData,
                options: .allowFragments
            ) as? [String: Any],
                let exp = jsonObject["exp"] as? Double,
                let timeStamp = TimeInterval(exactly: exp) {
                let expDate = Date(timeIntervalSince1970: timeStamp)
                return expDate.compare(Date()) == ComparisonResult.orderedDescending
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

public class AccessTokenRefresher {

    private let refreshRequestURL: String = ""
    private let session: Session

    public init() {
        let basicInterceptor = BasicAuthorizationRequestInterceptor()
        let configuration = URLSessionConfiguration.af.default
        self.session = Session(configuration: configuration, interceptor: basicInterceptor)
    }

    public func refreshToken(refreshToken: String, completion: @escaping (String?, String?) -> Void) {
        session
            .request(
                refreshRequestURL,
                method: .post,
                parameters: ["refreshToken": refreshToken],
                encoding: JSONEncoding.default
            )
            .responseDecodable(of: AuthorizationToken.self) { response in
                completion(response.value?.accessToken, response.value?.refreshToken)
            }
    }
}
