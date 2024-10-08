//
//  DailyContent.swift
//  CommunityClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public struct DailyContent {
    public let id: UUID
    public let imageURLs: [URL]
    public let likeCounts: Int
    public let isLike: Bool
    public let messageCounts: Int
    public let nickname: String
    public let profileImageURL: URL
    public let description: String
    public let createdAt: Date
    
    public init(
        id: UUID,
        imageURLs: [URL],
        likeCounts: Int,
        isLike: Bool,
        messageCounts: Int,
        nickname: String,
        profileImageURL: URL,
        description: String,
        createdAt: Date
    ) {
        self.id = id
        self.imageURLs = imageURLs
        self.likeCounts = likeCounts
        self.isLike = isLike
        self.messageCounts = messageCounts
        self.nickname = nickname
        self.profileImageURL = profileImageURL
        self.description = description
        self.createdAt = createdAt
    }
}
