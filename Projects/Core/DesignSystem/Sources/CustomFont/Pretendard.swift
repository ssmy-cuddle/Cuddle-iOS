//
//  Pretendard.swift
//  DesignSystem
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation
import SwiftUI

public enum Pretendard: FontRepresentable {
    case header
    case title
    case body
    
    public var familyName: String { "Pretendard" }
    public var name: String {
        [familyName, weightName].joined(separator: "-")
    }
    public var weight: Font.Weight {
        switch self {
        case .header: .semibold
        case .title: .bold
        case .body: .medium
        }
    }
    public var weightName: String {
        switch self {
        case .header: "SemiBold"
        case .title: "Bold"
        case .body: "Medium"
        }
    }
}

extension Pretendard: CaseIterable {}
