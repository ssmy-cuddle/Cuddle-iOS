//
//  RegisterSubCommentUseCase.swift
//  CommunityDomain
//
//  Created by mvldev7 on 9/2/24.
//

import Foundation

import BaseDomain

import Dependencies

public struct RegisterSubCommentUseCase: UseCase {
    
    @Dependency(\.dailyRepository) private var dailyRepository
    
    public func execute(parameters: Parameter) async throws -> Comment {
        try await dailyRepository.registerSubComment(
            commentID: parameters.commentID,
            commentText: parameters.text
        )
    }
}

extension RegisterSubCommentUseCase {
    
    public struct Parameter {
        public let commentID: UUID
        public let text: String
        
        public init(commentID: UUID, text: String) {
            self.commentID = commentID
            self.text = text
        }
    }
}
