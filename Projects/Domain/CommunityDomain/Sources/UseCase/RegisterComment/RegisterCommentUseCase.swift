//
//  RegisterCommentUseCase.swift
//  CommunityDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import BaseDomain

import Dependencies

public struct RegisterCommentUseCase: UseCase {
    
    @Dependency(\.dailyRepository) private var dailyRepository

    public func execute(parameters: Parameter) async throws -> [Comment] {
        try await dailyRepository.registerComment(
            id: parameters.id,
            commentText: parameters.commtentText
        )
    }
}

extension RegisterCommentUseCase {
    
    public struct Parameter {
        public let id: UUID
        public let commtentText: String
        
        public init(id: UUID, commtentText: String) {
            self.id = id
            self.commtentText = commtentText
        }
    }
}
