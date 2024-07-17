//
//  BannerModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation
import SwiftUI

import AppResource

public struct BannerModel {
    public let image: Image
    
    public init(image: Image) {
        self.image = image
    }
}

enum MockBanner {
    static let banners: [BannerModel] = [
        BannerModel(image: AppResourceAsset.Image.cuddleOriginalExampleImage1.swiftUIImage),
        BannerModel(image: AppResourceAsset.Image.cuddleOriginalExampleImage2.swiftUIImage),
        BannerModel(image: AppResourceAsset.Image.cuddleOriginalExampleImage1.swiftUIImage),
        BannerModel(image: AppResourceAsset.Image.cuddleOriginalExampleImage2.swiftUIImage)
    ]
}
