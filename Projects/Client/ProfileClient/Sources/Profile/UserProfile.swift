//
//  UserProfile.swift
//  ProfileClient
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

public struct UserProfile {
    public let id: UUID
    public let name: String
    public let description: String?
    public let imageURL: URL
    public let postCount: Int
    public let withDay: Int
    public let joinDay: Int
    public let cuddlersCount: Int
    public let cuddlers: [CuddlerProfile]
    
    public init(
        id: UUID,
        name: String,
        description: String?,
        imageURL: URL,
        postCount: Int,
        withDay: Int,
        joinDay: Int,
        cuddlersCount: Int,
        cuddlers: [CuddlerProfile]
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.postCount = postCount
        self.withDay = withDay
        self.joinDay = joinDay
        self.cuddlersCount = cuddlersCount
        self.cuddlers = cuddlers
    }
}
