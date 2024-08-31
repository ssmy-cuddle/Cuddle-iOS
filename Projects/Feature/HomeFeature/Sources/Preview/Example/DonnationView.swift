//
//  DonnationView.swift
//  HomeFeature
//
//  Created by mvldev7 on 8/30/24.
//

import Foundation
import SwiftUI

import AppResource

public struct DonnationView: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            ZStack {
                AppResourceAsset.Image.cuddleDonation.swiftUIImage
                    .resizable()
                    .aspectRatio(320 / 888, contentMode: .fit)
            }
        }
        .ignoresSafeArea()
    }
}
