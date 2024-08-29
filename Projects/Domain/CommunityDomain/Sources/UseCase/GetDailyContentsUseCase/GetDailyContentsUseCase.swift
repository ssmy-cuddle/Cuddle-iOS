//
//  GetDailyContentsUseCase.swift
//  CommunityDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import BaseDomain

import Dependencies

public struct GetDailyContentsUseCase: UseCase {
    
    @Dependency(\.dailyRepository) private var dailyRepository
    
    public func execute(
        parameters: EmptyParameter? = nil
    ) async throws -> [DailyContent] {
        try await dailyRepository.dailys()
    }
}
