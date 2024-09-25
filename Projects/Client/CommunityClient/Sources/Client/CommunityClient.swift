//
//  CommunityClient.swift
//  CommunityClient
//
//  Created by mvldev7 on 9/21/24.
//

import Foundation

import Dependencies
import DependenciesMacros

@DependencyClient
public struct CommunityClient {
    public var deleteComment: (_ id: UUID) async throws -> Comment
    public var deleteSubComment: (_ commentID: UUID, _ id: UUID) async throws -> Void
}
