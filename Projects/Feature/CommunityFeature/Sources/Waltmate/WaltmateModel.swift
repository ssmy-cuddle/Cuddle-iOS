//
//  WaltmateModel.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/18/24.
//

import Foundation

public struct WaltmateContentModel {
    public let id: UUID
    public let thumbnailURL: URL
    public let title: String
    public let description: String
    public let city: String
    public let startDate: Date
    public let applyCount: Int
    public let totalCount: Int
}

extension WaltmateContentModel: Equatable {}
