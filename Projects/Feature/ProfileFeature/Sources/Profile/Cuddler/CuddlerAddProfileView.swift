//
//  AddCuddlerProfileView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/20/24.
//

import Foundation
import SwiftUI

import AppResource

public struct CuddlerAddProfileView: View {
    public var body: some View {
        ZStack {
            Button(action: {}) {
                AppResourceAsset.Image.icSetting.swiftUIImage
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(135 / 187, contentMode: .fill)
        }
        .padding(.zero)
    }
}
