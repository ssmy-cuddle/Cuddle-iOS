//
//  OriginalContentModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/17/24.
//

import Foundation
import SwiftUI

import AppResource
import OriginalClient

public struct OriginalContentModel: Identifiable {
    public let id: UUID
    public let thumbnailImageURL: URL
    public let title: String
    public let description: String
    public let contentURL: URL
    
    public init(
        id: UUID,
        thumbnailImageURL: URL,
        title: String,
        description: String,
        contentURL: URL
    ) {
        self.id = id
        self.thumbnailImageURL = thumbnailImageURL
        self.title = title
        self.description = description
        self.contentURL = contentURL
    }
}

extension CuddleOriginal {
    var asModel: OriginalContentModel {
        OriginalContentModel(
            id: id,
            thumbnailImageURL: thumbnailImageURL,
            title: title,
            description: description,
            contentURL: contentURL
        )
    }
}

extension OriginalContentModel: Equatable {}

//enum MockOriginalContent {
//    static var contents: [OriginalContentModel] {
//        [
//            OriginalContentModel(
//                id: UUID(),
//                image: AppResourceAsset.Image.cuddleOriginalExampleImage1.swiftUIImage,
//                title: "Cuddle 신규 출시",
//                description: "cuddle이 새로 나왔다멍?"
//            ),
//            OriginalContentModel(
//                id: UUID(),
//                image: AppResourceAsset.Image.cuddleOriginalExampleImage2.swiftUIImage,
//                title: "Cuddle 신규 출시",
//                description: "cuddle이 새로 나왔다멍?"
//            ),
//            OriginalContentModel(
//                id: UUID(),
//                image: AppResourceAsset.Image.cuddleOriginalExampleImage1.swiftUIImage,
//                title: "Cuddle 신규 출시",
//                description: "cuddle이 새로 나왔다멍?"
//            ),
//            OriginalContentModel(
//                id: UUID(),
//                image: AppResourceAsset.Image.cuddleOriginalExampleImage2.swiftUIImage,
//                title: "Cuddle 신규 출시",
//                description: "cuddle이 새로 나왔다멍?"
//            )
//        ]
//    }
//}
//
//
