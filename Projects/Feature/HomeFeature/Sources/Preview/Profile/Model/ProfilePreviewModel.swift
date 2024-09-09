//
//  ProfilePreviewModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/29/24.
//

import Foundation

public struct ProfilePreviewModel {
    public let id: UUID
    public let profileImageURL: URL
    public let userProfileImageURL: URL
    public let nickname: String
}

extension ProfilePreviewModel: Equatable {}
