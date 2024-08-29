//
//  Gender+Mapper.swift
//  BaseFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseDomain

public extension Gender {
    var asModel: GenderModel {
        switch self {
        case .male: .male
        case .female: .male
        }
    }
}
