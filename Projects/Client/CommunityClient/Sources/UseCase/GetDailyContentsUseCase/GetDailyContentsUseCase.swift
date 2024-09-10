//
//  GetDailyContentsUseCase.swift
//  CommunityClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import BaseClient

import Dependencies

public struct GetDailyContentsUseCase: UseCase {
    
    @Dependency(\.dailyRepository) private var dailyRepository
    
    public func execute(
        parameters: EmptyParameter? = nil
    ) async throws -> [DailyContent] {
        try await dailyRepository.dailys()
    }
}
