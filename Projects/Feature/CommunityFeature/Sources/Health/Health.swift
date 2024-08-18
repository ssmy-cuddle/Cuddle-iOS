//
//  Health.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/14/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

@Reducer
public struct Health {
    
    @ObservableState
    public struct State: Equatable {
        public var contents: [HealthContentModel] = MockHealthContent.contents
    }
}

fileprivate enum MockHealthContent {
    static let contents: [HealthContentModel] = [
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/835/64/64.jpg?hmac=GeYiPY2TUmvwIr1RMOzf6fJ7SMZtWoTjK4Pn1x2YrwI")!,
            title: "거북이가 먹이를 거부해요",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/264/64/64.jpg?hmac=uP5TR-6pSSHq7RMAjIDID611ZJRRvWMOh5IMwra3ApM")!,
            title: "강아지가 갑자기 밥을 안 먹어요. 무슨 문제일까요?",
            description: "강아지가 원래 식욕이 많은 편이였는데 갑자기 밥을 먹지 않습니다. 왜 이러는지 알 수 있을까요???"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/131/64/64.jpg?hmac=KcUJ1P545bh_iRgDBpP_tVOJm7U7AUcNFiN1N5AXDQ4")!,
            title: "고슴도치가 계속 긁어요",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/267/64/64.jpg?hmac=E-cinWcppHZ8TQI4TTrFfKls7XF5pNRjn7YkmsnuifQ")!,
            title: "미어캣이 계속 기침을 해요",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/666/64/64.jpg?hmac=e7w9k1usO5GhjpIvyJuxYqG7ONyarLspwSeRuoPHxUY")!,
            title: "물고기의 지느러미가 갈라집니다.",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/835/64/64.jpg?hmac=GeYiPY2TUmvwIr1RMOzf6fJ7SMZtWoTjK4Pn1x2YrwI")!,
            title: "거북이가 먹이를 거부해요",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/264/64/64.jpg?hmac=uP5TR-6pSSHq7RMAjIDID611ZJRRvWMOh5IMwra3ApM")!,
            title: "강아지가 갑자기 밥을 안 먹어요. 무슨 문제일까요?",
            description: "강아지가 원래 식욕이 많은 편이였는데 갑자기 밥을 먹지 않습니다. 왜 이러는지 알 수 있을까요???"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/131/64/64.jpg?hmac=KcUJ1P545bh_iRgDBpP_tVOJm7U7AUcNFiN1N5AXDQ4")!,
            title: "고슴도치가 계속 긁어요",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/267/64/64.jpg?hmac=E-cinWcppHZ8TQI4TTrFfKls7XF5pNRjn7YkmsnuifQ")!,
            title: "미어캣이 계속 기침을 해요",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/666/64/64.jpg?hmac=e7w9k1usO5GhjpIvyJuxYqG7ONyarLspwSeRuoPHxUY")!,
            title: "물고기의 지느러미가 갈라집니다.",
            description: "같은 시간에 먹이를 배급하는데 갑자기 먹이를 거부합니다. 무슨 문제가 있을까요?"
        )
    ]
}
