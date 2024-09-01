//
//  GetCuddleOriginalListUseCase.swift
//  OriginalDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import BaseDomain

import Dependencies

public struct GetCuddleOriginalListUseCase: UseCase {
    
    @Dependency(\.cuddleOriginalRepository) private var cuddleOriginalRepository
    
    public func execute(
        parameters: EmptyParameter? = nil
    ) async throws -> [CuddleOriginal] {
        try await cuddleOriginalRepository.list()
    }
}
