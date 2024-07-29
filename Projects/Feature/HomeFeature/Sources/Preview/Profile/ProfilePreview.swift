//
//  ProfilePreview.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/29/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

@Reducer
public struct ProfilePreview {
    
    @ObservableState
    public struct State: Equatable {
        var contents: [ProfilePreviewModel] = MockProfilePreviewModel.items
    }
}

enum MockProfilePreviewModel {
    static var items: [ProfilePreviewModel] = [
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "건우"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/60/140/129.jpg?hmac=_dc9aTUt9b0mshEcR_WivN-nVD13eS-y3qbiFrmwCog")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "영은"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/6/140/129.jpg?hmac=SvOQzcJ-K7D5r2FKV90C7Ft0Oi07PtIoTYKjibLYHrc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "재성"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/400/140/129.jpg?hmac=Q01Z997tNjOWGrp-DLHut6o5kL2tNZdHPoLvoJlZ9lg")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "욱진"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "진혁"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "건우"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "건우"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "건우"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "건우"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "건우"
        ),
        ProfilePreviewModel(
            id: UUID(),
            profileImageURL: URL(string: "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            userProfileImageURL: URL(string:  "https://fastly.picsum.photos/id/549/20/20.jpg?hmac=J2XsP-Qx3mvC2zswUYG18zPdKBVPG-hl7glg8huGZWc")!,
            nickname: "건우"
        )
    ]
}
