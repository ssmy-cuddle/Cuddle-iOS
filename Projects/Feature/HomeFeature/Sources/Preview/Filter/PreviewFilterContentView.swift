//
//  PreviewFilterContentView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import DesignSystem

public struct PreviewFilterContentView: View {
    
    private enum Theme {
        enum Background {
            static let selected = Color(red: 0.54, green: 0.78, blue: 0.92)
            static let unselected = Color(red: 0.96, green: 0.96, blue: 0.96)
        }
    }
    
    let previewType: PreviewType
    let isSelected: Bool
    
    public init(previewType: PreviewType, isSelected: Bool) {
        self.previewType = previewType
        self.isSelected = isSelected
    }
    
    public var body: some View {
        Text(previewType.title)
            .font(.custom(NPS.body.name, size: 14))
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
            .foregroundStyle(isSelected ? Color.white : Color.black)
            .background(isSelected ? Theme.Background.selected : Theme.Background.unselected)
            .clipShape(.capsule)
    }
}
