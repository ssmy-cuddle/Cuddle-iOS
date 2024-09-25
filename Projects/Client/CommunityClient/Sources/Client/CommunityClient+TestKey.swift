//
//  CommunityClient+TestKey.swift
//  CommunityClient
//
//  Created by mvldev7 on 9/21/24.
//

import Foundation

import Dependencies

public enum CommunityClientError: Error {
    case unowned
}

extension CommunityClient: TestDependencyKey {
    
    public static var testValue: CommunityClient {
        CommunityClient(
            deleteComment: { try await Self.deleteComment(id: $0) },
            deleteSubComment: { try await Self.deleteComment(id: $0) }
        )
    }
    
    private static func deleteComment(id: UUID) async throws -> Comment {
        @Dependency(\.dailyRepository) var dailyRepository
        guard let deleteComment = MockDailyContent.comments.first(where: { $0.id == id }) else {
            throw CommunityClientError.unowned
        }
        MockDailyContent.comments = MockDailyContent.comments.filter {
            $0.id != id
        }
        return deleteComment
    }
    
    private static func deleteComment(id: UUID) async throws -> Comment {
        @Dependency(\.dailyRepository) var dailyRepository
        guard let deleteComment = MockDailyContent.comments.first(where: { $0.id == id }) else {
            throw CommunityClientError.unowned
        }
        MockDailyContent.comments = MockDailyContent.comments.filter {
            $0.id != id
        }
        return deleteComment
    }
}
