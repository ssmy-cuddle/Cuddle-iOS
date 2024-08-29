//
//  MockUserProfile.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

public enum MockUserProfile {
    
    enum Identifier {
        static let ggeonu = UUID(uuidString: "57ffc479-ee06-4550-96ba-182f8c17f0c7")!
    }
    
    public static let ggeonu = UserProfile(
        id: Identifier.ggeonu,
        name: "건우",
        description: "안녕하세요, 고라파덕 2마리와 함께하는 건우입니다.",
        imageURL: URL(string: "https://fastly.picsum.photos/id/787/300/300.jpg?hmac=INjE1ifrj7msPa8lJyw1K_wgWU1l8hfhQnX_uW6OTqE")!,
        postCount: 4,
        withDay: 20,
        joinDay: 3,
        cuddlersCount: 3,
        cuddlers: [
            MockCuddlerProfile.firstPaduck,
            MockCuddlerProfile.secondPaduck
        ]
    )
    
    public static let ggeonuRegistered = UserProfile(
        id: Identifier.ggeonu,
        name: "건우",
        description: "안녕하세요, 고라파덕 2마리와 함께하는 건우입니다.",
        imageURL: URL(string: "https://fastly.picsum.photos/id/787/300/300.jpg?hmac=INjE1ifrj7msPa8lJyw1K_wgWU1l8hfhQnX_uW6OTqE")!,
        postCount: 4,
        withDay: 20,
        joinDay: 3,
        cuddlersCount: 2,
        cuddlers: [
            MockCuddlerProfile.firstPaduck,
            MockCuddlerProfile.secondPaduck,
            MockCuddlerProfile.pikachu
        ]
    )
}
