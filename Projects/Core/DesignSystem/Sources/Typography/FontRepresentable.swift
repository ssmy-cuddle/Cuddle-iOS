//
//  FontRepresentable.swift
//  DesignSystem
//
//  Created by mvldev7 on 7/3/24.
//

import Foundation
import SwiftUI

public protocol FontRepresentable {
    var fontName: String { get }
    var weight: Font.Weight { get }
    var weightName: String { get }
}

public enum NPS: FontRepresentable {
    case header
    case title
    case body

    public var fontName: String {
        "NPSfont"
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
        case .header: "exterabold"
        case .title: "bold"
        case .body: "regular"
        }
    }
}

public enum Pretendard: FontRepresentable {
    case header
    case title
    case body
    
    public var fontName: String { "Pretendard" }
    public var weight: Font.Weight {
        switch self {
        case .header: .semibold
        case .title: .bold
        case .body: .medium
        }
    }
    public var weightName: String {
        switch self {
        case .header: "semibold"
        case .title: "bold"
        case .body: "medium"
        }
    }
}
