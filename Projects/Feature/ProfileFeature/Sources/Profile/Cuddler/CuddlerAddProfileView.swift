//
//  AddCuddlerProfileView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/20/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

public struct CuddlerAddProfileView: View {
    
    public let action: () -> Void
    
    public var body: some View {
        ZStack {
            Button(action: { action() }) {
                VStack(spacing: 18) {
                    Text("반려동물을\n추가해주세요")
                        .font(.npsTitle14)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                    
                    AppResourceAsset.Image.icPlusFilled.swiftUIImage
                        .frame(width: 24, height: 24)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(135 / 187, contentMode: .fill)
            .background(Color(red: 0.91, green: 0.91, blue: 0.91))
            .clipShape(.rect(cornerRadius: 23))
            .shadow(color: .black.opacity(0.15), radius: 3, x: .zero, y: 3)
        }
        .padding(.zero)
    }
}
