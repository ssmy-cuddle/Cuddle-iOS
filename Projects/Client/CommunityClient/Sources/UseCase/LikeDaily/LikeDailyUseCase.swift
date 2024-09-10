//
//  LikeDailyUseCase.swift
//  CommunityClient
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import BaseClient

import Dependencies

public struct LikeDailyUseCase: UseCase {
    
    @Dependency(\.dailyRepository) private var dailyRepository
    
    public func execute(parameters: Parameter) async throws -> DailyContent {
        try await dailyRepository.like(
            id: parameters.id,
            parameters.isLike
        )
    }
}

extension LikeDailyUseCase {
    public struct Parameter {
        public let id: UUID
        public let isLike: Bool
        
        public init(id: UUID, isLike: Bool) {
            self.id = id
            self.isLike = isLike
        }
    }
}
