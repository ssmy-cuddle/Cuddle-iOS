//
//  UserProfile+Mapper.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import ProfileDomain

public extension UserProfile {
    var asModel: UserProfileModel {
        UserProfileModel(
            id: id,
            name: name,
            description: description,
            imageURL: imageURL,
            postCount: postCount,
            withDay: withDay,
            joinDay: joinDay,
            cuddlersCount: cuddlersCount,
            cuddlers: cuddlers.map(\.asModel)
        )
    }
}
