//
//  DailyRepository.swift
//  CommunityDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

import BaseDomain

public protocol DailyRepository: Repository {
    func dailys() async throws -> [DailyContent]
    func register(
        parameters: RegisterDailyContentParameter
    ) async throws -> DailyContent
}
