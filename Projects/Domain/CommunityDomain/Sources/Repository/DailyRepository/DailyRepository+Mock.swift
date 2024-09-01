//
//  DailyRepository+Mock.swift
//  CommunityDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public struct MockDailyRepository: DailyRepository {
    
    public static var isRegisterd: Bool = false
    public static var isCommented: Bool = false
    
    public init() {}
    
    public func dailys() async throws -> [DailyContent] {
        try await Task.sleep(for: .milliseconds(1000))
        return (Self.isRegisterd ? [MockDailyContent.paduck] : []) +
        MockDailyContent.items
    }
    
    public func register(
        parameters: RegisterDailyContentParameter
    ) async throws -> DailyContent {
        MockDailyRepository.isRegisterd = true
        try await Task.sleep(for: .milliseconds(1000))
        return MockDailyContent.paduck
    }
    
    public func like(id: UUID, _ isLike: Bool) async throws -> DailyContent {
        if let index = MockDailyContent.items.firstIndex(where: { $0.id == id }) {
            MockDailyContent.items[index] = DailyContent(
                id: MockDailyContent.items[index].id,
                imageURLs: MockDailyContent.items[index].imageURLs,
                likeCounts: MockDailyContent.items[index].likeCounts + (isLike ? 1 : -1),
                isLike: isLike,
                messageCounts: MockDailyContent.items[index].messageCounts,
                nickname: MockDailyContent.items[index].nickname,
                profileImageURL: MockDailyContent.items[index].profileImageURL,
                description: MockDailyContent.items[index].description,
                createdAt: MockDailyContent.items[index].createdAt
            )
            return MockDailyContent.items[index]
        }
        return MockDailyContent.ggeonu
    }
    
    public func commentList(id: UUID) async throws -> [Comment] {
        MockDailyContent.comments + [
            Self.isRegisterd ? MockDailyContent.commentByGeonwoo : nil
        ].compactMap { $0 }
    }
    
    public func registerComment(
        id: UUID,
        commentText: String
    ) async throws -> [Comment] {
        Self.isRegisterd = true
        return MockDailyContent.comments + [MockDailyContent.commentByGeonwoo]
    }
}
