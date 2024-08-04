//
//  DailyContentModel.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/4/24.
//

import Foundation

public struct DailyContentModel {
    public let id: UUID
    public let imageURLs: [URL]
    public let likeCounts: Int
    public let messageCounts: Int
    public let nickname: String
    public let profileIageURL: URL
    public let description: String
    public let createdAt: Date
    
    public init(
        id: UUID,
        imageURLs: [URL],
        likeCounts: Int,
        messageCounts: Int,
        nickname: String,
        profileIageURL: URL,
        description: String,
        createdAt: Date
    ) {
        self.id = id
        self.imageURLs = imageURLs
        self.likeCounts = likeCounts
        self.messageCounts = messageCounts
        self.nickname = nickname
        self.profileIageURL = profileIageURL
        self.description = description
        self.createdAt = createdAt
    }
}

extension DailyContentModel: Equatable {}
