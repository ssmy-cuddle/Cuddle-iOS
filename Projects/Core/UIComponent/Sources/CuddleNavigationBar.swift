//
//  CuddleNavigationBar.swift
//  UIComponent
//
//  Created by mvldev7 on 9/7/24.
//

import Foundation
import SwiftUI

import AppResource

public struct CuddleNavigationBar: View {
    
    private var onButtonTap: () -> Void
    
    public init(onButtonTap: @escaping () -> Void) {
        self.onButtonTap = onButtonTap
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 17 + 16 + 16)
                .frame(maxWidth: .infinity)
                .shadow(color: .black.opacity(0.1), radius: 3, x: .zero, y: 4)
            
            Button(
                action: { onButtonTap() }
            ) {
                AppResourceAsset.Image.icButtonBack.swiftUIImage
                    .foregroundColor(.black)
                    .frame(width: 36, height: 36, alignment: .leading)
            }
        }
    }
}
