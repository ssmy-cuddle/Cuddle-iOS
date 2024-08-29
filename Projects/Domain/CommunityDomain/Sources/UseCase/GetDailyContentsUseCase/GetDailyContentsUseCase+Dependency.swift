//
//  GetDailyContentsUseCase+Dependency.swift
//  CommunityDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import Dependencies

public extension DependencyValues {
    var getDailyContentsUseCase: GetDailyContentsUseCase {
        get { self[GetDailyContentsUseCase.self] }
        set { self[GetDailyContentsUseCase.self] = newValue }
    }
}

extension GetDailyContentsUseCase: TestDependencyKey {
    public static var testValue: GetDailyContentsUseCase {
        GetDailyContentsUseCase()
    }
}
