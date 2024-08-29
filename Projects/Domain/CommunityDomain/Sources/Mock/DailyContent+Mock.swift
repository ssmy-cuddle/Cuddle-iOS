//
//  DailyContent+Mock.swift
//  CommunityDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public enum MockDailyContent {
    
    public static let paduck = DailyContent(
        id: UUID(),
        imageURLs: [
            URL(string: "https://i.namu.wiki/i/6cHcn6OyBsdtqLwmgIRaTdy2cQKTtSm-zz9OYPuAq0AE4DLyB32P5yIUq1Zvssw070t7GTfdDEeM7QbhxLJ_ew.webp")!,
            URL(string: "https://static.wikia.nocookie.net/pokemon/images/f/f3/%EA%B3%A0%EB%9D%BC%ED%8C%8C%EB%8D%95_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405011541&path-prefix=ko")!
        ],
        likeCounts: 0,
        messageCounts: 0,
        nickname: "건우",
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "우리 파덕이 귀엽죠?",
        createdAt: Date().addingTimeInterval(-50)
    )
    
    public static let ggeonu = DailyContent(
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
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static let ggeonu1 = DailyContent(
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
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static let ggeonu2 = DailyContent(
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
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static let ggeonu3 = DailyContent(
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
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static let ggeonu4 = DailyContent(
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
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
}
