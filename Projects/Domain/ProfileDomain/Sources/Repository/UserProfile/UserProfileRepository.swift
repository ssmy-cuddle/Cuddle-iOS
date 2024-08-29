//
//  UserProfileRepository.swift
//  ProfileDomain
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseDomain

public protocol UserProfileRepository: Repository, Sendable {
    func user() async throws -> UserProfile
}
