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
    func like(id: UUID, _ isLike: Bool) async throws -> DailyContent
    func commentList(id: UUID) async throws -> [Comment]
    func registerComment(id: UUID, commentText: String) async throws -> [Comment]
    func registerSubComment(commentID: UUID, commentText: String) async throws -> Comment
}
