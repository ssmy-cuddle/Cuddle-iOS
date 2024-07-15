//
//  CuddleButton.swift
//  DesignSystem
//
//  Created by mvldev7 on 7/8/24.
//

import Foundation
import SwiftUI

import AppResource

public enum CuddleButtonTheme {
    public enum ThemeColor {
        case yellow
        case blue
        case custom(Color)
        
        var color: Color {
            switch self {
            case .yellow: AppResourceAsset.Color.dubbyYellow.swiftUIColor
            case .blue: AppResourceAsset.Color.lubbyBlue.swiftUIColor
            case let .custom(color): color
            }
        }
    }
    
    case primary(ThemeColor)
    case secondary(ThemeColor)
    case outline(ThemeColor)
    
    var textColor: Color {
        switch self {
        case .primary: .white
        case let .secondary(themeColor): themeColor.color
        case .outline: .black
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case let .primary(theme): theme.color
        case .secondary: AppResourceAsset.Color.buttonSecondary.swiftUIColor
        case .outline: .white
        }
    }
}

public struct CuddleTextButton: View {
    
    private let theme: CuddleButtonTheme
    private let action: () -> Void
    private let text: String
    private let font: Font
    
    public init(
        action: @escaping () -> Void,
        theme: CuddleButtonTheme,
        text: String,
        font: Font
    ) {
        self.theme = theme
        self.action = action
        self.text = text
        self.font = font
    }
    
    public var body: some View {
        Button(
            action: action,
            label: {
                Text(text)
                    .font(font)
                    .padding(.vertical, 16)
                    .foregroundStyle(theme.textColor)
                    .frame(maxWidth: .infinity)
            }
        )
        .background(theme.backgroundColor)
        .cornerRadius(25)
    }
}
