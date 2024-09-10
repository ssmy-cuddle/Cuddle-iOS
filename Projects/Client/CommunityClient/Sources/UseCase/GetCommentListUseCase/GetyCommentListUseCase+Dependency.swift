//
//  GetCommentListUseCase+Dependency.swift
//  CommunityClient
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import Dependencies

extension DependencyValues {
    public var getCommentListUseCase: GetCommentListUseCase {
        get { self[GetCommentListUseCase.self] }
        set { self[GetCommentListUseCase.self] = newValue }
    }
}

extension GetCommentListUseCase: TestDependencyKey {
    public static var testValue: GetCommentListUseCase {
        GetCommentListUseCase()
    }
}
