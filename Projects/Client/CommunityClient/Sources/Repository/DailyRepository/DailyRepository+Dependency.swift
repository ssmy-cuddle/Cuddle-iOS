//
//  DailyRepository+Dependency.swift
//  CommunityClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import Dependencies

public enum DailyRepositoryKey: TestDependencyKey {
    public static var testValue: DailyRepository {
        MockDailyRepository()
    }
}

public extension DependencyValues {
    var dailyRepository: DailyRepository {
        get { self[DailyRepositoryKey.self] }
        set { self[DailyRepositoryKey.self] = newValue }
    }
}

