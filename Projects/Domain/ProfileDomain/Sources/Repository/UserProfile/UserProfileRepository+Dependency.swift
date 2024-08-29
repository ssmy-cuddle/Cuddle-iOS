//
//  UserProfileRepository+Dependency.swift
//  ProfileDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import Dependencies

public enum UserProfileRepositoryKey: TestDependencyKey {
    public static var testValue: UserProfileRepository {
        MockUserProfileRepository()
    }
}

public extension DependencyValues {
    var userProfileRepository: UserProfileRepository {
        get { self[UserProfileRepositoryKey.self] }
        set { self[UserProfileRepositoryKey.self] = newValue }
    }
}
