//
//  MockUserProfileRepository.swift
//  ProfileClient
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import Dependencies

public struct MockUserProfileRepository: UserProfileRepository {
    
    public static var isRegistered: Bool = false
    
    public init() {}
    
    public func user() async throws -> UserProfile {
        try await Task.sleep(for: .milliseconds(1000))
        return MockUserProfileRepository.isRegistered ? MockUserProfile.ggeonuRegistered : MockUserProfile.ggeonu
    }
}
