//
//  DiaryView+Example.swift
//  DiaryFeature
//
//  Created by mvldev7 on 9/20/24.
//

import Foundation
import SwiftUI

import DiaryFeature

import ComposableArchitecture

public struct DiaryViewExample: View {
    
    public init() {}
    
    public var body: some View {
        DiaryNavigationView(
            store: StoreOf<DiaryNavigation>(
                initialState: DiaryNavigation.State()
            ) {
                DiaryNavigation()
            }
        )
    }
}

#Preview {
    DiaryViewExample()
}
