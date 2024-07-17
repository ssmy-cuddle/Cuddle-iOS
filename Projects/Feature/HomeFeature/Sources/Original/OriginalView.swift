//
//  OriginalView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import DesignSystem

public struct OriginalView: View {
    
    private let contents: [OriginalContentModel]
    
    public init(contents: [OriginalContentModel]) {
        self.contents = contents
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Cuddle Originals")
                .font(.npsHeader16)
                .padding(.horizontal, 16)
                .padding(.bottom, 12)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 12) {
                    ForEach(contents) { OriginalContentView(content: $0) }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .contentMargins(.horizontal, 16)
        }
    }
}
