//
//  CuddlerGenderModel.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation

public enum GenderModel {
    case male
    case female
}

extension GenderModel {
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

extension GenderModel: Equatable {}
extension GenderModel: CaseIterable {}
