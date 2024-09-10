//
//  UpdateCuddlerProfileUseCase.swift
//  ProfileClient
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseClient

import Dependencies

public struct UpdateCuddlerProfileUseCase: UseCase {
    
    @Dependency(\.cuddlerProfileRepository) var cuddlerRepository
    
    public func execute(parameters: Parameter) async throws -> CuddlerProfile {
        try await cuddlerRepository.update(
            id: parameters.id,
            parameters: parameters.parameters
        )
    }
}

extension UpdateCuddlerProfileUseCase {
    public struct Parameter {
        public let id: UUID
        public let parameters: UpdateCuddlerProfileParameter
        
        public init(id: UUID, parameters: UpdateCuddlerProfileParameter) {
            self.id = id
            self.parameters = parameters
        }
    }
}
