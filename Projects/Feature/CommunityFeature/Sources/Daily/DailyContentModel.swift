//
//  DailyContentModel.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/4/24.
//

import Foundation

import CommunityDomain

public struct DailyContentModel {
    public let id: UUID
    public let imageURLs: [URL]
    public let likeCounts: Int
    public let isLike: Bool
    public let messageCounts: Int
    public let nickname: String
    public let profileIageURL: URL
    public let description: String
    public let createdAt: Date
    
    public init(
        id: UUID,
        imageURLs: [URL],
        likeCounts: Int,
        isLike: Bool,
        messageCounts: Int,
        nickname: String,
        profileIageURL: URL,
        description: String,
        createdAt: Date
    ) {
        self.id = id
        self.imageURLs = imageURLs
        self.likeCounts = likeCounts
        self.isLike = isLike
        self.messageCounts = messageCounts
        self.nickname = nickname
        self.profileIageURL = profileIageURL
        self.description = description
        self.createdAt = createdAt
    }
}

extension DailyContent {
    var asModel: DailyContentModel {
        DailyContentModel(
            id: id,
            imageURLs: imageURLs,
            likeCounts: likeCounts,
            isLike: isLike,
            messageCounts: messageCounts,
            nickname: nickname,
            profileIageURL: profileImageURL,
            description: description,
            createdAt: createdAt
        )
    }
}


extension DailyContentModel: Equatable {}

