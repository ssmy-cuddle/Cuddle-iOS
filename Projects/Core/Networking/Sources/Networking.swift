//
//  Networking.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

import Alamofire

public class Networking {

    private let session: Session

    public init(
        interceptor: RequestInterceptor
    ) {
        self.session = Session(
            configuration: URLSessionConfiguration.af.default,
            interceptor: interceptor
        )
    }

    private func request<T: Decodable, P: Encodable>(
        _ url: String,
        method: HTTPMethod,
        parameters: P? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        let encodedParameters: Data? = if let parameters = parameters {
            try JSONEncoder().encode(parameters)
        } else {
            nil
        }
        
        let request = try await session.request(
            url,
            method: method,
            parameters: parameters?.alamofireParameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
            .validate()
            .serializingDecodable(T.self, emptyResponseCodes: [200, 202, 204, 205])
            .value
        return request
    }

    // GET 요청
    public func get<Response: Decodable, Parameter: Encodable>(_ url: String, parameters: Parameter?) async throws -> Response {
        return try await request(url, method: .get, parameters: parameters)
    }

    // POST 요청
    public func post<Response: Decodable, Parameter: Encodable>(_ url: String, parameters: Parameter?) async throws -> Response {
        return try await request(url, method: .post, parameters: parameters)
    }

    // PUT 요청 (업데이트)
    public func put<Response: Decodable, Parameter: Encodable>(_ url: String, parameters: Parameter?) async throws -> Response {
        return try await request(url, method: .put, parameters: parameters)
    }

    // DELETE 요청
    public func delete<Response: Decodable, Parameter: Encodable>(_ url: String, parameters: Parameter?) async throws -> Response {
        return try await request(url, method: .delete, parameters: parameters)
    }

    // Multipart Form Data를 사용하는 파일 업로드
    public func upload<T: Decodable>(
        _ url: String,
        data: Data,
        fileName: String,
        mimeType: String,
        parameters: [String: String]? = nil) async throws -> T {

        let request = try await session.upload(multipartFormData: { formData in
            formData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)

            // 추가적인 파라미터를 multipart form에 추가
            if let parameters = parameters {
                for (key, value) in parameters {
                    formData.append(Data(value.utf8), withName: key)
                }
            }
        }, to: url)
        .validate()
        .serializingDecodable(T.self)
        .value
        
        return request
    }
}


fileprivate extension Encodable {
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }

    var alamofireParameters: Parameters? {
        asDictionary(using: encoder)
    }
    
    func asDictionary(using encoder: JSONEncoder = JSONEncoder()) -> [String: Any]? {
        guard let data = try? encoder.encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }
}
