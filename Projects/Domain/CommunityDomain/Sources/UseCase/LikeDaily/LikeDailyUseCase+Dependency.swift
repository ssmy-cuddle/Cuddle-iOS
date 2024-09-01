//
//  LikeDailyUseCase+Dependency.swift
//  CommunityDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import Dependencies

extension DependencyValues {
    public var likeDailyUseCase: LikeDailyUseCase {
        get { self[LikeDailyUseCase.self] }
        set { self[LikeDailyUseCase.self] = newValue }
    }
}

extension LikeDailyUseCase: TestDependencyKey {
    public static var testValue: LikeDailyUseCase {
        LikeDailyUseCase()
    }
}
