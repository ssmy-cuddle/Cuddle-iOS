//
//  RegisterDailyContentUseCase.swift
//  CommunityClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import BaseClient

import Dependencies

public struct RegisterDailyContentUseCase: UseCase {
    
    @Dependency(\.dailyRepository) private var dailyRepository
    
    public func execute(
        parameters: RegisterDailyContentParameter
    ) async throws -> DailyContent {
        try await dailyRepository.register(
            parameters: parameters
        )
    }
}
