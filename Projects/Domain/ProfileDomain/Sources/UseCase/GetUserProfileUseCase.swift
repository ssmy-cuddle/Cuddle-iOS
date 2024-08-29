//
//  GetUserProfileUseCase.swift
//  ProfileDomain
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseDomain

import Dependencies

public struct GetUserProfileUseCase: UseCase {
    
    @Dependency(\.userProfileRepository) var userRepository: UserProfileRepository
    
    public init() {}
    
    public func execute(
        parameters _: EmptyParameter? = nil
    ) async throws -> UserProfile {
        try await userRepository.user()
    }
}

extension DependencyValues {
    public var getUserProfileUseCase: GetUserProfileUseCase {
        get { self[GetUserProfileUseCase.self] }
        set { self[GetUserProfileUseCase.self] = newValue }
    }
}

extension GetUserProfileUseCase: TestDependencyKey {
    public static var testValue: GetUserProfileUseCase {
        GetUserProfileUseCase()
    }
}
