//
//  Waltmate.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/18/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

@Reducer
public struct Waltmate {
    
    @ObservableState
    public struct State: Equatable {
        public var contents: [WaltmateContentModel] = MockWaltmateContent.contents
    }
}

enum MockWaltmateContent {
    static let contents: [WaltmateContentModel] = [
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        ),
        .init(
            id: UUID(),
            thumbnailURL: URL(string: "https://fastly.picsum.photos/id/1081/200/200.jpg?hmac=jyxOLb8HFEGU9gP9khyXdMjr1zDV7sT6gv1_mYxlheY")!,
            title: "산책메이트 구해요!",
            description: "매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!! 매주 토요일 아침에 강아지와 산책을 나가는데, 함께 할 사람 구합니다 !!!!",
            city: "상도동",
            startDate: Date().addingTimeInterval(60 * 60 * 24 * 1),
            applyCount: 2,
            totalCount: 3
        )
    ]
}
