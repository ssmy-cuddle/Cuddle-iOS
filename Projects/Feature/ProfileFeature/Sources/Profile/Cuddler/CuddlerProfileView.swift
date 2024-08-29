//
//  CuddlerProfileView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/20/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem
import ProfileFeatureInterface

import Kingfisher

public struct CuddlerProfileView: View {
    
    let cuddler: CuddlerProfileModel
    let editAction: (CuddlerProfileModel) -> Void
       
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            AppResourceAsset.Image.icProfileCuddlerBackground.swiftUIImage
                .resizable()
                .aspectRatio(135 / 187, contentMode: .fit)
            
            Button(action: { editAction(cuddler) }) {
                AppResourceAsset.Image.icProfileEdit.swiftUIImage
                    .foregroundStyle(.black)
            }
            .frame(width: 24, height: 24)
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            
            VStack(spacing: .zero) {
                Text(cuddler.name)
                    .font(.npsTitle14)
                    .padding(.top, 26)
                    .padding(.bottom, 8)
                
                KFImage(cuddler.imageURL)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(.horizontal, 30)
                    .clipShape(.circle)

                (Text("함께한지 ") +
                Text("\(cuddler.withDay)")
                    .foregroundStyle(AppResourceAsset.Color.lubbyBlue.swiftUIColor) +
                Text(" 일째"))
                .font(.npsTitle12)
                .padding(.top, 18)
                .padding(.bottom, 22)
            }
        }
        .shadow(
            color: .black.opacity(0.15),
            radius: 5,
            x: .zero,
            y: 7
        )
    }
}
