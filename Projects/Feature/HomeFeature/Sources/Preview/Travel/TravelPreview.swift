//
//  TravelPreview.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct TravelPreview {
    
    @ObservableState
    public struct State: Equatable {
        var tarvels: [TravelPreviewModel] = MockTravelPreview.contents
    }
}

enum MockTravelPreview {
    static var contents: [TravelPreviewModel] {
        [
            TravelPreviewModel(
                id: UUID(),
                thumbnailURLList: [
                    URL(string: "https://fastly.picsum.photos/id/1083/140/129.jpg?hmac=Dzb3YcrN8FjBEAAF6QRaOZvr96xZ7yKqwHaqw7059B8")!,
                    URL(string: "https://fastly.picsum.photos/id/717/140/129.jpg?hmac=m1Q5C4dr9QXy6kgYa02L2Ovuu0FNEQcXo-iYqLZ5utM")!
                ], 
                nickname: "건우",
                profileImage: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!
                ,
                title: "나서스랑 바다 여행 다녀왔어요 :)",
                description: "우리 강아지 '나서스'와 함께 강릉 주문진으로 여행을 다녀왔다. 나서스는 바다를 처음 봐서 그런지 너무 신나했다"
            ),
            TravelPreviewModel(
                id: UUID(),
                thumbnailURLList: [
                    URL(string: "https://fastly.picsum.photos/id/1083/140/129.jpg?hmac=Dzb3YcrN8FjBEAAF6QRaOZvr96xZ7yKqwHaqw7059B8")!,
                    URL(string: "https://fastly.picsum.photos/id/717/140/129.jpg?hmac=m1Q5C4dr9QXy6kgYa02L2Ovuu0FNEQcXo-iYqLZ5utM")!
                ],
                nickname: "건우",
                profileImage: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!
                ,
                title: "나서스랑 바다 여행 다녀왔어요 :)",
                description: "우리 강아지 '나서스'와 함께 강릉 주문진으로 여행을 다녀왔다. 나서스는 바다를 처음 봐서 그런지 너무 신나했다"
            )
        ]
    }
}
