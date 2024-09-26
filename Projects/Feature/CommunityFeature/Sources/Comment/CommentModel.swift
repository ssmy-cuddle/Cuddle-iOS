//
//  CommentModel.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import CommunityClient

public struct CommentModel {
    public let id: UUID
    public let text: String
    public let name: String
    public let profileImageURL: URL
    public let createdAt: Date
    public let subComments: [SubCommentModel]
    
    public init(
        id: UUID,
        text: String,
        name: String,
        profileImageURL: URL,
        createdAt: Date,
        subComments: [SubCommentModel]
    ) {
        self.id = id
        self.text = text
        self.name = name
        self.profileImageURL = profileImageURL
        self.createdAt = createdAt
        self.subComments = subComments
    }
    
}

extension CommentModel: Equatable {}

public struct SubCommentModel {
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

extension SubCommentModel: Equatable {}

//
//extension CommunityClient.Comment {
//    var asModel: CommentModel {
//        CommentModel(
//            id: id,
//            text: text,
//            name: name, 
//            profileImageURL: profileImageURL,
//            createdAt: createdAt,
//            subComments: subComments.map { $0.asModel }
//        )
//    }
//}

extension SubComment {
    var asModel: SubCommentModel {
        SubCommentModel(
            id: id,
            text: text,
            name: name,
            profileImageURL: profileImageURL,
            createdAt: createdAt
        )
    }
}
