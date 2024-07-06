//
//  FontRepresentable.swift
//  DesignSystem
//
//  Created by mvldev7 on 7/3/24.
//

import Foundation
import SwiftUI

import AppResource

public protocol FontRepresentable {
    var familyName: String { get }
    var name: String { get }
    var weight: Font.Weight { get }
    var weightName: String { get }
}

public extension FontRepresentable {    
    func register(scope: CTFontManagerScope? = .process) {
        guard let fontURL = Bundle.appResource.url(forResource: name, withExtension: ".ttf") else {
            return
        }
        CTFontManagerRegisterFontsForURL(
            fontURL as CFURL,
            .process,
            nil
        )
    }
}
