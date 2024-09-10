//
//  MockCuddlerProfile.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

public enum MockCuddlerProfile {
    
    enum Identifier {
        static let firstPaduck = UUID(uuidString: "f90c0ee5-be9a-4685-973f-4a49e7f50400")!
        static let secondPaduck = UUID(uuidString: "b75720e4-e832-4d86-949e-c9d4f160ad14")!
        static let pikachu = UUID(uuidString: "47749780-7d5b-4ada-a82c-4b9c39622cce")!
    }
    
    static let firstPaduck = CuddlerProfile(
        id: Identifier.firstPaduck,
        name: "큰 파덕이",
        imageURL: URL(string: "https://static.wikia.nocookie.net/pokemon/images/f/f3/%EA%B3%A0%EB%9D%BC%ED%8C%8C%EB%8D%95_%EA%B3%B5%EC%8B%9D_%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8.png/revision/latest?cb=20170405011541&path-prefix=ko")!,
        withDay: 40,
        gender: .male,
        birth: Date().addingTimeInterval(60 * 60 * 24 * -240),
        kind: "오리너구리",
        weight: 12.7,
        description: "아주 귀여운 고라파덕",
        withDate: Date().addingTimeInterval(60 * 60 * 24 * -40),
        endDate: nil
    )
    
    static let secondPaduck = CuddlerProfile(
        id: Identifier.secondPaduck,
        name: "작은 파덕이",
        imageURL: URL(string: "https://i.namu.wiki/i/6cHcn6OyBsdtqLwmgIRaTdy2cQKTtSm-zz9OYPuAq0AE4DLyB32P5yIUq1Zvssw070t7GTfdDEeM7QbhxLJ_ew.webp")!,
        withDay: 17,
        gender: .female,
        birth: Date().addingTimeInterval(60 * 60 * 24 * -127),
        kind: "오리너구리",
        weight: 22.2,
        description: "아주 매우 정말 귀여운 고라파덕",
        withDate: Date().addingTimeInterval(60 * 60 * 24 * -11),
        endDate: nil
    )
    
    static let pikachu = CuddlerProfile(
        id: Identifier.pikachu,
        name: "피카츄",
        imageURL: URL(string: "https://i.namu.wiki/i/l0x04r27DjSQmS-WgYk6I5x6IkKMyvZjRMyK5dI3EMoMikzCd2Kfl2SMRdvL3-y4zpxI_qLP-fs3QToSR7AU3g.webp")!,
        withDay: 1,
        gender: .female,
        birth: Date().addingTimeInterval(60 * 60 * 24 * -20),
        kind: "쥐",
        weight: 20.0,
        description: "아주 매우 정말 귀여운 피카츄",
        withDate: Date().addingTimeInterval(60 * 60 * 24 * -1),
        endDate: nil
    )
    
}
