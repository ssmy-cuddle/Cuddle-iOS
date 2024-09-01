//
//  CuddleOriginal+Mock.swift
//  OriginalDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

public enum MockCuddleOriginal {
    
    public static let cuddleOpen = CuddleOriginal(
        id: UUID(),
        thumbnailImageURL: URL(string: "https://fastly.picsum.photos/id/219/678/468.jpg?hmac=kVlNWcuKRUoTndt0NBSYuixeTGphVXHsGkavYRkmfXw")!,
        title: "Cuddle 신규 출시",
        description: "Cuddle이 새로 나왔다멍?",
        contentURL: URL(string: "https://www.naver.com")!
    )
    
    public static let cuddleOpen2 = CuddleOriginal(
        id: UUID(),
        thumbnailImageURL: URL(string: "https://fastly.picsum.photos/id/237/678/468.jpg?hmac=7957iqBXV_Mx8cHhTP-cXNX73XxFwaOukQfWLJcamag")!,
        title: "Cuddle 신규 출시",
        description: "Cuddle이 새로 나왔다멍?",
        contentURL: URL(string: "https://www.google.com")!
    )
}
