//
//  DailyRepository+Mock.swift
//  CommunityClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public enum MockDailyRepositoryError: Error {
    case idNotFound
}

public struct MockDailyRepository: DailyRepository {
    
    public init() {}
    
    public func dailys() async throws -> [DailyContent] {
        try await Task.sleep(for: .milliseconds(1000))
        return MockDailyContent.items
    }
    
    public func register(
        parameters: RegisterDailyContentParameter
    ) async throws -> DailyContent {
        MockDailyContent.isRegisterd = true
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
        MockDailyContent.comments
    }
    
    public func registerComment(
        id: UUID,
        commentText: String
    ) async throws -> [Comment] {
        MockDailyContent.comments += [
            Comment(
                id: UUID(),
                text: commentText,
                name: "건우", 
                profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
                createdAt: Date().addingTimeInterval(-1),
                userUUID: MockDailyContent.Identifier.ggenou,
                subComments: []
            )
        ]
        return MockDailyContent.comments
    }
    
    public func registerSubComment(
        commentID: UUID,
        commentText: String
    ) async throws -> Comment {
        if let index = MockDailyContent.comments.firstIndex(where: { $0.id == commentID }) {
            let subComment = SubComment(
                id: UUID(),
                text: commentText,
                name: "건우",
                profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
                createdAt: Date(),
                userUUID: MockDailyContent.Identifier.ggenou
            )
            MockDailyContent.comments[index] = Comment(
                id: MockDailyContent.comments[index].id,
                text: MockDailyContent.comments[index].text,
                name: MockDailyContent.comments[index].name,
                profileImageURL: MockDailyContent.comments[index].profileImageURL,
                createdAt: MockDailyContent.comments[index].createdAt,
                userUUID: MockDailyContent.comments[index].userUUID,
                subComments: MockDailyContent.comments[index].subComments + [subComment]
            )
            return MockDailyContent.comments[index]
        }
        throw MockDailyRepositoryError.idNotFound
    }
}
