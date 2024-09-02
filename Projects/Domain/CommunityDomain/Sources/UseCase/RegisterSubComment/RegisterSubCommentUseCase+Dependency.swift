//
//  RegisterSubCommentUseCase+Dependency.swift
//  CommunityDomain
//
//  Created by mvldev7 on 9/2/24.
//

import Foundation

import Dependencies

extension DependencyValues {
    public var registerSubCommentUseCase: RegisterSubCommentUseCase {
        get { self[RegisterSubCommentUseCase.self] }
        set { self[RegisterSubCommentUseCase.self] = newValue }
    }
}

extension RegisterSubCommentUseCase: TestDependencyKey {
    public static var testValue: RegisterSubCommentUseCase {
        RegisterSubCommentUseCase()
    }
}
