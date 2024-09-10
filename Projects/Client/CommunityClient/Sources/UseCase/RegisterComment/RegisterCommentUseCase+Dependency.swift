//
//  RegisterCommentUseCase+Dependency.swift
//  CommunityClient
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import Dependencies

extension DependencyValues {
    public var registerCommentUseCase: RegisterCommentUseCase {
        get { self[RegisterCommentUseCase.self] }
        set { self[RegisterCommentUseCase.self] = newValue }
    }
}

extension RegisterCommentUseCase: TestDependencyKey {
    public static var testValue: RegisterCommentUseCase {
        RegisterCommentUseCase()
    }
}
