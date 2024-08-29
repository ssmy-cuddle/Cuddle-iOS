//
//  GenderModel.swift
//  BaseFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseDomain

public enum GenderModel {
    case male
    case female
}

public extension GenderModel {
    var title: String {
        switch self {
        case .male: "남자"
        case .female: "여자"
        }
    }
    
    var shortenTitle: String {
        switch self {
        case .male: "남"
        case .female: "여"
        }
    }
}

public extension GenderModel {
    var asEntity: Gender {
        switch self {
        case .male: .male
        case .female: .female
        }
    }
}

extension GenderModel: CaseIterable {}
extension GenderModel: Equatable {}
