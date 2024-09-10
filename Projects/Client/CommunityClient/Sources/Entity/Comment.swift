//
//  Comment.swift
//  CommunityClient
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation


public struct Comment {
    public let id: UUID
    public let text: String
    public let name: String
    public let profileImageURL: URL
    public let createdAt: Date
    public let subComments: [SubComment]
    
    public init(
        id: UUID,
        text: String,
        name: String,
        profileImageURL: URL,
        createdAt: Date,
        subComments: [SubComment]
    ) {
        self.id = id
        self.text = text
        self.name = name
        self.profileImageURL = profileImageURL
        self.createdAt = createdAt
        self.subComments = subComments
    }
    
}

extension Comment: Equatable {}

public struct SubComment {
    public let id: UUID
    public let text: String
    public let name: String
    public let profileImageURL: URL
    public let createdAt: Date
    
    public init(
        id: UUID,
        text: String,
        name: String,
        profileImageURL: URL,
        createdAt: Date
    ) {
        self.id = id
        self.text = text
        self.name = name
        self.profileImageURL = profileImageURL
        self.createdAt = createdAt
    }
}

extension SubComment: Equatable {}
