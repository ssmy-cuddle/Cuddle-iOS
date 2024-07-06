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
    var fileName: String { get }
}

public extension FontRepresentable {    
    func register() {
        print("================ \(fileName)")
        guard let fontURL = Bundle.designSystem.url(forResource: fileName, withExtension: ".ttf") else {
            print("Register Did Failed")
            return
        }
        CTFontManagerRegisterFontsForURL(
            fontURL as CFURL,
            .process,
            nil
        )
    }
}

public enum NPS: FontRepresentable {
    case header
    case title
    case body

    public var fontName: String {
        "NPS-font"
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
    public var fileName: String {
        [fontName, weightName].joined(separator: "-")
    }
}

extension NPS: CaseIterable {}

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
        case .header: "SemiBold"
        case .title: "Bold"
        case .body: "Medium"
        }
    }
    public var fileName: String {
        [fontName, weightName].joined(separator: "-")
    }
}

extension Pretendard: CaseIterable {}
