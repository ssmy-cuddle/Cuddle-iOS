//
//  CuddlerProfileRepository+Dependency.swift
//  ProfileClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import Dependencies

public enum CuddlerProfileRepositoryKey: TestDependencyKey {
    public static var testValue: CuddlerProfileRepository {
        MockCuddlerProfileRepository()
    }
}

public extension DependencyValues {
    var cuddlerProfileRepository: CuddlerProfileRepository {
        get { self[CuddlerProfileRepositoryKey.self] }
        set { self[CuddlerProfileRepositoryKey.self] = newValue }
    }
}
