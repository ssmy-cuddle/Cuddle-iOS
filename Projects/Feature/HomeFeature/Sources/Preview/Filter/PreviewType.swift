//
//  PreviewType.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation

public enum PreviewType {
    case daily
    case travels
    case cuddlers
    
    public static let `default`: PreviewType = .daily
}

extension PreviewType: CaseIterable {}

extension PreviewType {
    var title: String {
        switch self {
        case .daily: "일상"
        case .travels: "여행기"
        case .cuddlers: "Cuddle과 함께하는 동물들"
        }
    }
}
