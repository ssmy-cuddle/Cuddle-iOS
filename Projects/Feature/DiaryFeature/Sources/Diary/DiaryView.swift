//
//  DiaryView.swift
//  DiaryFeature
//
//  Created by mvldev7 on 9/20/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct DiaryView: View {
    
    private var store: StoreOf<DiaryFeature>
    
    public init(store: StoreOf<DiaryFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            // 여기 View 작성
            Color.blue
        }
    }
}
