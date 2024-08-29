//
//  CuddlerProfile+Mapper.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import ProfileDomain

public extension CuddlerProfile {
    var asModel: CuddlerProfileModel {
        CuddlerProfileModel(
            id: id,
            name: name,
            imageURL: imageURL,
            withDay: withDay,
            gender: gender.asModel,
            birth: birth,
            kind: kind,
            weight: weight,
            description: description,
            withDate: withDate,
            endDate: endDate
        )
    }
}
