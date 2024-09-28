//
//  BasicAuthorizationNetworkingInterceptor.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

import Alamofire

final class BasicAuthorizationRequestInterceptor: RequestInterceptor {
    private var maxRetryCount: Int = 3
    
    // MARK: - Adaptor
    
    func adapt(_ urlRequest: URLRequest, for _: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        let basicToken = Data("".utf8).base64EncodedString()
        urlRequest.setValue("Basic " + basicToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    // MARK: - Retrier
    
    func retry(_ request: Request, for _: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount <= maxRetryCount else {
            completion(.doNotRetry)
            return
        }
        if [
            NSURLErrorCannotConnectToHost,
            NSURLErrorTimedOut,
            NSURLErrorNetworkConnectionLost,
            NSURLErrorNotConnectedToInternet
        ].contains((error as NSError).code) {
            completion(.retryWithDelay(0.5))
        } else {
            completion(.doNotRetry)
        }
    }
}
