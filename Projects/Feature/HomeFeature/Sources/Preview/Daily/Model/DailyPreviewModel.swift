//
//  DailyPreviewModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation

public struct DailyPreviewModel {
    let id: UUID
    let thumbnailURL: URL
    let profileImage: URL
    let title: String
    let nickname: String
}

extension DailyPreviewModel: Equatable {}
