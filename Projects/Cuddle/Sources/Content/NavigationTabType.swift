//
//  NavigationTabType.swift
//  Cuddle
//
//  Created by mvldev7 on 7/20/24.
//

import Foundation
import SwiftUI

import AppResource

public enum NavigationTabType {
    case home
    case diary
    case comumnity
    case donation
    case profile
    
    public static let `default`: NavigationTabType = .home
}

extension NavigationTabType: Hashable {}

extension NavigationTabType: CaseIterable {}

extension NavigationTabType {
    var icon: Image {
        switch self {
        case .home: AppResourceAsset.Image.icNavigationHome.swiftUIImage
        case .diary: AppResourceAsset.Image.icNavigationDiary.swiftUIImage
        case .comumnity: AppResourceAsset.Image.icNavigationCommunity.swiftUIImage
        case .donation: AppResourceAsset.Image.icNavigationDonation.swiftUIImage
        case .profile: AppResourceAsset.Image.icNavigationProfile.swiftUIImage
        }
    }
    
    var title: String {
        switch self {
        case .home: "홈"
        case .diary: "여정"
        case .comumnity: "커뮤니티"
        case .donation: "기부"
        case .profile: "프로필"
        }
    }
    
    var tintColor: Color {
        switch self {
        case .home: Color(red: 0.35, green: 0.68, blue: 0.89)
        case .diary: AppResourceAsset.Color.dubbyYellow.swiftUIColor
        case .comumnity: Color(red: 0.35, green: 0.89, blue: 0.66)
        case .donation: Color(red: 1, green: 0.39, blue: 0.68)
        case .profile: .black
        }
    }
}
