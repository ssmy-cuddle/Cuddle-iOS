//
//  DailyContent+Mock.swift
//  CommunityClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public enum MockDailyContent {
    
    public static var isRegisterd: Bool = false
    public static var isCommented: Bool = false
    
    public enum Identifier {
        static let paduck = UUID(uuidString: "e5fa320b-3464-4fd3-9ae4-751c79db9ec9")!
        static let ggenou = UUID(uuidString: "064d22c8-d6f7-45a9-9957-4df752ec6769")!
        static let ggenou1 = UUID(uuidString: "ca2ab142-74f2-41fe-ade1-d488d9451839")!
        static let ggenou2 = UUID(uuidString: "d46a150b-88c2-4175-ac52-b88db88d4442")!
        static let ggenou3 = UUID(uuidString: "e9f8a0d1-4fc9-4f60-8702-d4207ed6ce79")!
        static let ggenou4 = UUID(uuidString: "b4e12aff-7c60-4601-9d10-0f6a39377b4d")!
    }
    
    public static var items: [DailyContent] = [
        isRegisterd ? paduck : nil,
        ggeonu,
        ggeonu1,
        ggeonu2,
        ggeonu3,
        ggeonu4,
    ].compactMap { $0 }
    
    public static var paduck = DailyContent(
        id: Identifier.paduck,
        imageURLs: [
            URL(string: "https://i.namu.wiki/i/6cHcn6OyBsdtqLwmgIRaTdy2cQKTtSm-zz9OYPuAq0AE4DLyB32P5yIUq1Zvssw070t7GTfdDEeM7QbhxLJ_ew.webp")!,
            URL(string: "https://static.wikia.nocookie.net/pokemon/images/f/f3/%EA%B3%A0%EB%9D%BC%ED%8C%8C%EB%8D%95_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405011541&path-prefix=ko")!
        ],
        likeCounts: 0,
        isLike: false,
        messageCounts: 0,
        nickname: "건우",
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "우리 파덕이 귀엽죠?",
        createdAt: Date().addingTimeInterval(-50)
    )
    
    public static var ggeonu = DailyContent(
        id: Identifier.ggenou,
        imageURLs: [
            URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
            URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
            URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
            URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
        ],
        likeCounts: 16,
        isLike: true,
        messageCounts: 4,
        nickname: "건우",
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static var ggeonu1 = DailyContent(
        id: Identifier.ggenou1,
        imageURLs: [
            URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
            URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
            URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
            URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
        ],
        likeCounts: 16,
        isLike: false,
        messageCounts: 4,
        nickname: "건우",
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static var ggeonu2 = DailyContent(
        id: Identifier.ggenou2,
        imageURLs: [
            URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
            URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
            URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
            URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
        ],
        likeCounts: 16,
        isLike: false,
        messageCounts: 4,
        nickname: "건우",
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static var ggeonu3 = DailyContent(
        id: Identifier.ggenou3,
        imageURLs: [
            URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
            URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
            URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
            URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
        ],
        likeCounts: 16,
        isLike: false,
        messageCounts: 4,
        nickname: "건우",
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public static var ggeonu4 = DailyContent(
        id: Identifier.ggenou4,
        imageURLs: [
            URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
            URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
            URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
            URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
        ],
        likeCounts: 16,
        isLike: false,
        messageCounts: 4,
        nickname: "건우",
        profileImageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
        description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
        createdAt: Date().addingTimeInterval(-120)
    )
    
    public enum CommentIdentifier {
        static var yeongeun = UUID(uuidString: "6e026c1e-324b-4a5a-bd76-50b1196013f3")!
        static var ggeonu = UUID(uuidString: "192563eb-08f0-40e9-a9ae-16af1f1ab6ea")!
        static var jaeseong = UUID(uuidString: "ce2765ef-8a6d-4bb3-be57-857ee80b21eb")!
        static var jinhyuck = UUID(uuidString: "08ae3c3d-fdf8-4afc-b7c3-1e1b8e9085d3")!
        static var ukjin = UUID(uuidString: "2f252001-7afb-4c8a-91dc-1e020e07842a")!
    }
    
    public static var yeongeun = Comment(
        id: CommentIdentifier.yeongeun,
        text: "같이 산책하고 싶네요~^^",
        name: "영은",
        profileImageURL: URL(
            string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8"
        )!,
        createdAt: Date().addingTimeInterval(
            60 * -6
        ),
        subComments: [
            SubComment(
                id: UUID(),
                text: "어디 사세요?",
                name: "건우",
                profileImageURL: URL(
                    string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc"
                )!,
                createdAt: Date().addingTimeInterval(60 * -4)
            ),
            SubComment(
                id: UUID(),
                text: "봉천동이요!",
                name: "영은",
                profileImageURL: URL(
                    string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8"
                )!,
                createdAt: Date().addingTimeInterval(60 * -2)
            )
        ]
    )
    
    public static var ggeonuComment = Comment(
        id: CommentIdentifier.ggeonu,
        text: "너무 귀여워요",
        name: "건우",
        profileImageURL: URL(
            string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8"
        )!,
        createdAt: Date().addingTimeInterval(
            60 * -4
        ),
        subComments: []
    )
    
    public static var jinhyuck = Comment(
        id: CommentIdentifier.jinhyuck,
        text: "아이가 몇살 인가요?",
        name: "진혁",
        profileImageURL: URL(
            string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8"
        )!,
        createdAt: Date().addingTimeInterval(
            60 * -3
        ),
        subComments: []
    )
    
    public static var comments: [Comment] = [
        yeongeun,
        jinhyuck,
        isCommented ? ggeonuComment : nil
    ].compactMap { $0 }
}
