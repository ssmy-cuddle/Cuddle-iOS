//
//  NPS.swift
//  DesignSystem
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation
import SwiftUI

public enum NPS: FontRepresentable {
    case header
    case title
    case body

    public var familyName: String { "NPS-font" }
    public var name: String {
        [familyName, weightName].joined(separator: "-")
    }
    public var weight: Font.Weight {
        switch self {
        case .header: .heavy
        case .title: .bold
        case .body: .regular
        }
    }
    public var weightName: String {
        switch self {
        case .header: "ExtraBold"
        case .title: "Bold"
        case .body: "Regular"
        }
    }
}

extension NPS: CaseIterable {}
