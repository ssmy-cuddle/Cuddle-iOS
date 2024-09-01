//
//  GetCommentListUseCase.swift
//  CommunityDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import BaseDomain

import Dependencies

public struct GetCommentListUseCase: UseCase {
    
    @Dependency(\.dailyRepository) private var dailyRepository
        
    public func execute(parameters: Parameter) async throws -> [Comment] {
        try await dailyRepository.commentList(id: parameters.id)
    }
}

extension GetCommentListUseCase {
    public struct Parameter {
        public let id: UUID
        
        public init(id: UUID) {
            self.id = id
        }
    }
}
