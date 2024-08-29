//
//  CuddlerProfileRepository+Mock.swift
//  ProfileDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public struct MockCuddlerProfileRepository: CuddlerProfileRepository {
    
    public init() {}
    
    private var cuddlers: [CuddlerProfile] = [
        MockCuddlerProfile.firstPaduck,
        MockCuddlerProfile.secondPaduck,
        MockCuddlerProfile.pikachu
    ]
    
    public func register(
        parameters: UpdateCuddlerProfileParameter
    ) async throws -> CuddlerProfile {
        MockUserProfileRepository.isRegistered = true
        try await Task.sleep(for: .milliseconds(1000))
        return MockCuddlerProfile.pikachu
    }
    
    public func update(
        id: UUID,
        parameters: UpdateCuddlerProfileParameter
    ) async throws -> CuddlerProfile {
        MockUserProfileRepository.isRegistered = true
        try await Task.sleep(for: .milliseconds(1000))
        return MockCuddlerProfile.pikachu
    }
}
