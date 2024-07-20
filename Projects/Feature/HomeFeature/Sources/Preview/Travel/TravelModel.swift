//
//  TravelModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation

public struct TravelPreviewModel {
    let id: UUID
    let thumbnailURLList: [URL]
    let nickname: String
    let profileImage: URL
    let title: String
    let description: String}

extension TravelPreviewModel: Equatable {}
