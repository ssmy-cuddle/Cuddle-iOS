//
//  CuddlerProfileRepository.swift
//  ProfileDomain
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseDomain

public protocol CuddlerProfileRepository: Repository {
    func register(
        parameters: UpdateCuddlerProfileParameter
    ) async throws -> CuddlerProfile
    
    func update(
        id: UUID,
        parameters: UpdateCuddlerProfileParameter
    ) async throws -> CuddlerProfile
}
