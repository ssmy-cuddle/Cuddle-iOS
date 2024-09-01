//
//  CuddleOriginalRepository+Dependency.swift
//  OriginalDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import Dependencies

public enum CuddleOriginalRepositoryKey: TestDependencyKey {
    public static var testValue: CuddleOriginalRepository {
        MockCuddleOriginalRepository()
    }
}

public extension DependencyValues {
    var cuddleOriginalRepository: CuddleOriginalRepository {
        get { self[CuddleOriginalRepositoryKey.self] }
        set { self[CuddleOriginalRepositoryKey.self] = newValue }
    }
}
