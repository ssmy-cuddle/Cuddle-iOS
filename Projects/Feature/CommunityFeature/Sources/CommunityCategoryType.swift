//
//  CommunityCategory.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/1/24.
//

import Foundation
import SwiftUI

import AppResource

public enum CommunityCategoryType {
    case daily
    case travel
    case walkmate
    case health
}

extension CommunityCategoryType: CaseIterable {}

public extension CommunityCategoryType {
    
    var icon: Image {
        switch self {
        case .daily: AppResourceAsset.Image.icCommunityDaily.swiftUIImage
        case .travel: AppResourceAsset.Image.icCommunityTravel.swiftUIImage
        case .walkmate: AppResourceAsset.Image.icCommunityWalkmate.swiftUIImage
        case .health: AppResourceAsset.Image.icCommunityHealth.swiftUIImage
        }
    }
    
    var title: String {
        switch self {
        case .daily: "일상"
        case .travel: "여행기"
        case .walkmate: "산책메이트"
        case .health: "건강관리"
        }
    }
    
    var tintColor: Color {
        switch self {
        case .daily: Color(red: 1, green: 0.45, blue: 0.45)
        case .travel: Color(red: 0.82, green: 0.43, blue: 1)
        case .walkmate: AppResourceAsset.Color.lubbyBlue.swiftUIColor
        case .health: AppResourceAsset.Color.cuddleGreen.swiftUIColor
        }
    }
}
