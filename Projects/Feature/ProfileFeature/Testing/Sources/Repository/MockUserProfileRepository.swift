//
//  MockUserProfileRepository.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseDomain
import ProfileDomain

public struct MockUserProfileRepository: UserProfileRepository {
    
    var isRegistered: Bool = false
    
    public init() {}
    
    public func user() async throws -> UserProfile {
        try await Task.sleep(for: .milliseconds(1500))
        return isRegistered ? MockUserProfile.ggeonuRegistered : MockUserProfile.ggeonu
    }
}
