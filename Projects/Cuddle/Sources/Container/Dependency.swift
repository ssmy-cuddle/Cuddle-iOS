//
//  Dependency.swift
//  Cuddle
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import ProfileClient
//import ProfileFeatureTesting

import Dependencies

//extension DependencyValues {
//    public static func configure() {
//        DependencyValues[\.live.getUserPro/*fileUseCase] = GetUserProfileUseCase()*/
//    }
//}

extension GetUserProfileUseCase: DependencyKey {
    public static var liveValue: GetUserProfileUseCase {
        GetUserProfileUseCase()
    }
}

//extension UserProfileRepositoryKey: DependencyKey {
//    public static var liveValue: any UserProfileRepository {
//        UserProfileRepositoryImpl()
//    }
//}

//public struct UserProfileRepositoryImpl: UserProfileRepository {
//    
//    var isRegistered: Bool = false
//    
//    public init() {}
//    
//    public func user() async throws -> UserProfile {
//        try await Task.sleep(for: .milliseconds(2000))
//        return UserProfile(
//            id: UUID(),
//            name: "건우",
//            description: "안녕하세요, 고라파덕 2마리와 함께하는 건우입니다.",
//            imageURL: URL(string: "https://fastly.picsum.photos/id/787/300/300.jpg?hmac=INjE1ifrj7msPa8lJyw1K_wgWU1l8hfhQnX_uW6OTqE")!,
//            postCount: 4,
//            withDay: 20,
//            joinDay: 3,
//            cuddlersCount: 2,
//            cuddlers: []
//        )
//    }
//}
