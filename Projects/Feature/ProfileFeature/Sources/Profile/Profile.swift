//
//  Profile.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/19/24.
//

import Foundation

import ComposableArchitecture

public enum CuddlerViewType {
    case profile(CuddlerModel)
    case add
    
    public var value: String {
        switch self {
        case let .profile(profile): profile.name
        case .add: "add"
        }
    }
}

extension CuddlerViewType: Equatable {}

@Reducer
public struct Profile {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public var profile: ProfileModel? = MockProfile.profile
        public var cuddlerItems: [CuddlerViewType] {
            (profile?.cuddlers ?? []).map { .profile($0) } + [.add]
        }
        
        public init() {}
    }
}

enum MockProfile {
    static var profile: ProfileModel {
        .init(
            id: UUID(),
            name: "건우",
            description: "안녕하세요, 고라파덕 2마리와 함께하는 건우입니다.",
            imageURL: URL(string: "https://fastly.picsum.photos/id/787/300/300.jpg?hmac=INjE1ifrj7msPa8lJyw1K_wgWU1l8hfhQnX_uW6OTqE")!,
            postCount: 4,
            withDay: 20,
            joinDay: 3,
            cuddlersCount: 2,
            cuddlers: [
                .init(name: "큰 파덕이", imageURL: URL(string: "https://static.wikia.nocookie.net/pokemon/images/f/f3/%EA%B3%A0%EB%9D%BC%ED%8C%8C%EB%8D%95_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405011541&path-prefix=ko")!, withDay: 40),
                .init(name: "작은 파덕이", imageURL: URL(string: "https://i.namu.wiki/i/6cHcn6OyBsdtqLwmgIRaTdy2cQKTtSm-zz9OYPuAq0AE4DLyB32P5yIUq1Zvssw070t7GTfdDEeM7QbhxLJ_ew.webp")!, withDay: 24)
            ]
        )
    }
}
