//
//  RegisterCuddlerProfileUseCase.swift
//  ProfileClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import BaseClient

import Dependencies


public struct RegisterCuddlerProfileUseCase: UseCase {
    
    @Dependency(\.cuddlerProfileRepository) var cuddlerProfileRepository
    
    public func execute(
        parameters: UpdateCuddlerProfileParameter
    ) async throws -> CuddlerProfile {
        try await cuddlerProfileRepository.register(
            parameters: parameters
        )
    }
}

extension RegisterCuddlerProfileUseCase: TestDependencyKey {
    public static var testValue: RegisterCuddlerProfileUseCase {
        RegisterCuddlerProfileUseCase()
    }
}

public extension DependencyValues {
    var registerCuddlerProfileUseCase: RegisterCuddlerProfileUseCase {
        get { self[RegisterCuddlerProfileUseCase.self] }
        set { self[RegisterCuddlerProfileUseCase.self] = newValue }
    }
}
