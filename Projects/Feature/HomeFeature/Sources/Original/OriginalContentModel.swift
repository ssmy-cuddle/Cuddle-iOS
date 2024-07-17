//
//  OriginalContentModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/17/24.
//

import Foundation
import SwiftUI

import AppResource

public struct OriginalContentModel: Identifiable {
    public let id: UUID
    public let image: Image
    public let title: String
    public let description: String
    
    public init(id: UUID, image: Image, title: String, description: String) {
        self.id = id
        self.image = image
        self.title = title
        self.description = description
    }
}

enum MockOriginalContent {
    static var contents: [OriginalContentModel] {
        [
            OriginalContentModel(
                id: UUID(),
                image: AppResourceAsset.Image.cuddleOriginalExampleImage1.swiftUIImage,
                title: "Cuddle 신규 출시",
                description: "cuddle이 새로 나왔다멍?"
            ),
            OriginalContentModel(
                id: UUID(),
                image: AppResourceAsset.Image.cuddleOriginalExampleImage2.swiftUIImage,
                title: "Cuddle 신규 출시",
                description: "cuddle이 새로 나왔다멍?"
            ),
            OriginalContentModel(
                id: UUID(),
                image: AppResourceAsset.Image.cuddleOriginalExampleImage1.swiftUIImage,
                title: "Cuddle 신규 출시",
                description: "cuddle이 새로 나왔다멍?"
            ),
            OriginalContentModel(
                id: UUID(),
                image: AppResourceAsset.Image.cuddleOriginalExampleImage2.swiftUIImage,
                title: "Cuddle 신규 출시",
                description: "cuddle이 새로 나왔다멍?"
            )
        ]
    }
}


