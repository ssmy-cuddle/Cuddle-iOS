//
//  GetCuddleOriginalListUseCase+Dependency.swift
//  OriginalDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import Dependencies

extension GetCuddleOriginalListUseCase: TestDependencyKey {
    public static var testValue: GetCuddleOriginalListUseCase {
        GetCuddleOriginalListUseCase()
    }
}

public extension DependencyValues {
    var getCuddleOriginalListUseCase: GetCuddleOriginalListUseCase {
        get { self[GetCuddleOriginalListUseCase.self] }
        set { self[GetCuddleOriginalListUseCase.self] = newValue }
    }
}
