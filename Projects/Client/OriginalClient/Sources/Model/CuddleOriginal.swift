//
//  CuddleOriginal.swift
//  OriginalClient
//
//  Created by mvldev7 on 8/31/24.
//

import Foundation

public struct CuddleOriginal {
    public let id: UUID
    public let thumbnailImageURL: URL
    public let title: String
    public let description: String
    public let contentURL: URL
    
    public init(
        id: UUID,
        thumbnailImageURL: URL,
        title: String,
        description: String,
        contentURL: URL
    ) {
        self.id = id
        self.thumbnailImageURL = thumbnailImageURL
        self.title = title
        self.description = description
        self.contentURL = contentURL
    }
}
