//
//  AuthenticationClient+TestKey.swift
//  AuthenticationClient
//
//  Created by mvldev7 on 9/19/24.
//

import Foundation

import Dependencies

public enum AuthenticationClientError: Error {}

extension AuthenticationClient: TestDependencyKey {
    
    public static var testValue: AuthenticationClient = AuthenticationClient(
        authentication: { Self.authentication() },
        requestAuthentication: { _, _ in try await Self.requestAuthentication() },
        removeAuthentication: { try await Self.removeAuthentication() }
    )
    
    private static func authentication() -> Authentication? {
        guard let userToken = Self.loadToken(forKey: AuthenticationClient.userTokenKey) else {
            return nil
        }
        return Authentication(token: userToken)
    }
    
    private static func requestAuthentication() async throws -> Authentication {
        try await Task.sleep(for: .milliseconds(1000))
        let token = "Example Token"
        let _ = Self.saveToken(token, forKey: AuthenticationClient.userTokenKey)
        return Authentication(token: token)
    }
    
    private static func removeAuthentication() async throws -> Void {
        try await Task.sleep(for: .milliseconds(1000))
        let _ = Self.deleteToken(forKey: AuthenticationClient.userTokenKey)
        return Void()
    }
}

extension AuthenticationClient {
    static let userTokenKey = "userToken"
    
    static func loadToken(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }

        return nil
    }
    
    // MARK: For Debug
    
    static func deleteToken(forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)

        return status == errSecSuccess
    }
    
    static func saveToken(_ token: String, forKey key: String) -> Bool {
        guard let data = token.data(using: .utf8) else { return false }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary) // 기존 데이터 삭제 (중복 방지)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
}
