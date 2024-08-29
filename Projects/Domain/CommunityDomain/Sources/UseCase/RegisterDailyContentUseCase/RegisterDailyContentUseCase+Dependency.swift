//
//  RegisterDailyContentUseCase+Dependency.swift
//  CommunityDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import Dependencies

public extension DependencyValues {
    var registerDailyContentUseCase: RegisterDailyContentUseCase {
        get { self[RegisterDailyContentUseCase.self] }
        set { self[RegisterDailyContentUseCase.self] = newValue }
    }
}

extension RegisterDailyContentUseCase: TestDependencyKey {
    public static var testValue: RegisterDailyContentUseCase {
        RegisterDailyContentUseCase()
    }
}
