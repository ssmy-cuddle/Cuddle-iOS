//
//  ScrollObserver.swift
//  UIComponent
//
//  Created by mvldev7 on 9/5/24.
//

import Foundation
import SwiftUI

public struct ScrollObserverableView: View {
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: proxy.frame(in: .global).minY
                )
        }
        .frame(height: 0)
    }
}

public struct ScrollOffsetKey: PreferenceKey {
    public static var defaultValue: CGFloat = 0
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
