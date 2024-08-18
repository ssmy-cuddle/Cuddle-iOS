//
//  HealthContentModel.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/14/24.
//

import Foundation

public struct HealthContentModel {
    public let id: UUID
    public let thumbnailURL: URL
    public let title: String
    public let description: String
    
    public init(id: UUID, thumbnailURL: URL, title: String, description: String) {
        self.id = id
        self.thumbnailURL = thumbnailURL
        self.title = title
        self.description = description
    }
}

extension HealthContentModel: Equatable {}
