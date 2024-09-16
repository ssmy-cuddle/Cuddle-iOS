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
    
    private enum DisabledColor {
        static let foreground = Color(red: 0.74, green: 0.74, blue: 0.74)
        static let background = Color(red: 0.96, green: 0.96, blue: 0.96)
    }
    
    private let theme: CuddleButtonTheme
    private let action: () -> Void
    private let text: String
    private let font: Font
    
    @Binding var isEnabled: Bool
    
    public init(
        action: @escaping () -> Void,
        theme: CuddleButtonTheme,
        text: String,
        font: Font,
        isEnabled: Binding<Bool> = .constant(true)
    ) {
        self.theme = theme
        self.action = action
        self.text = text
        self.font = font
        self._isEnabled = isEnabled
    }
    
    public var body: some View {
        Button(
            action: action,
            label: {
                Text(text)
                    .font(font)
                    .padding(.vertical, 16)
                    .foregroundStyle(isEnabled ? theme.textColor : DisabledColor.foreground)
                    .frame(maxWidth: .infinity)
            }
        )
        .background(isEnabled ? theme.backgroundColor : DisabledColor.background)
        .cornerRadius(25)
        .disabled(!isEnabled)
    }
}
