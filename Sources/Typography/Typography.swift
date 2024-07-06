//
//  Typography.swift
//  DesignSystem
//
//  Created by mvldev7 on 7/3/24.
//

import Foundation
import SwiftUI

public extension Font {
    
    private static func typography(font: FontRepresentable, size: CGFloat) -> Font {
        let fontName = [font.fontName, font.weightName].joined(separator: "-")
        return .custom(fontName, size: size)
    }
    
    static let appFonts: [FontRepresentable] = NPS.allCases + Pretendard.allCases
    
    // MARK: NPS - Header
    
    static let npsHeader20: Font = .typography(font: NPS.header, size: 20)
    static let npsHeader18: Font = .typography(font: NPS.header, size: 18)
    static let npsHeader16: Font = .typography(font: NPS.header, size: 16)
    
    // MARK: NPS - Title
    
    static let npsTitle16: Font = .typography(font: NPS.title, size: 16)
    static let npsTitle14: Font = .typography(font: NPS.title, size: 14)
    static let npsTitle12: Font = .typography(font: NPS.title, size: 12)
    static let npsTitle10: Font = .typography(font: NPS.title, size: 10)
    
    // MARK: NPS - Body
    
    static let npsBody12: Font = .typography(font: NPS.body, size: 12)
    static let npsBody10: Font = .typography(font: NPS.body, size: 10)
    static let npsBody8: Font = .typography(font: NPS.body, size: 8)
    
    // MARK: Pretendard - Header
    
    static let pretendardHeader20: Font = .typography(font: Pretendard.header, size: 20)
    static let pretendardHeader18: Font = .typography(font: Pretendard.header, size: 18)
    static let pretendardHeader16: Font = .typography(font: Pretendard.header, size: 16)
    
    // MARK: Pretendard - Title
    
    static let pretendardTitle16: Font = .typography(font: Pretendard.title, size: 16)
    static let pretendardTitle14: Font = .typography(font: Pretendard.title, size: 14)
    static let pretendardTitle12: Font = .typography(font: Pretendard.title, size: 12)
    static let pretendardTitle10: Font = .typography(font: Pretendard.title, size: 10)
    
    // MARK: Pretendard - Body
    
    static let pretendardBody14: Font = .typography(font: Pretendard.body, size: 14)
    static let pretendardBody12: Font = .typography(font: Pretendard.body, size: 12)
    static let pretendardBody10: Font = .typography(font: Pretendard.body, size: 10)
    static let pretendardBody8: Font = .typography(font: Pretendard.body, size: 8)
    static let pretendardBody6: Font = .typography(font: Pretendard.body, size: 6)
}

public extension Bundle {
    static var designSystem: Bundle { .module }
}
