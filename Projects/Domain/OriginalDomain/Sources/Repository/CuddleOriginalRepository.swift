//
//  CuddleOriginalRepository.swift
//  OriginalDomain
//
//  Created by mvldev7 on 8/31/24.
//

import Foundation

import BaseDomain

public protocol CuddleOriginalRepository: Repository {
    func list() async throws -> [CuddleOriginal]
}
