//
//  Daily.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/5/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

@Reducer
public struct Daily {
    
    @ObservableState
    public struct State: Equatable {
        let dailys: [DailyContentModel] = DailyContentModel.mockDailys
    }
}

extension DailyContentModel {
    static let mockDailys: [DailyContentModel] = [
        .init(
            id: UUID(),
            imageURLs: [
                URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
                URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
                URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
                URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
            ], 
            likeCounts: 16,
            messageCounts: 4,
            nickname: "건우",
            profileIageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
            description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
            createdAt: Date().addingTimeInterval(-120)
        ),
        .init(
            id: UUID(),
            imageURLs: [
                URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
                URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
                URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
                URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
            ],
            likeCounts: 16,
            messageCounts: 4,
            nickname: "건우",
            profileIageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
            description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
            createdAt: Date().addingTimeInterval(-120)
        ),
        .init(
            id: UUID(),
            imageURLs: [
                URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
                URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
                URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
                URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
            ],
            likeCounts: 16,
            messageCounts: 4,
            nickname: "건우",
            profileIageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
            description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
            createdAt: Date().addingTimeInterval(-120)
        )
    ]
}
