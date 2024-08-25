//
//  ProfileModel.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/19/24.
//

import Foundation

public struct ProfileModel {
    public let id: UUID
    public let name: String
    public let description: String?
    public let imageURL: URL
    public let postCount: Int
    public let withDay: Int
    public let joinDay: Int
    public let cuddlersCount: Int
    public let cuddlers: [CuddlerModel]
    
    public init(
        id: UUID,
        name: String,
        description: String?,
        imageURL: URL,
        postCount: Int,
        withDay: Int,
        joinDay: Int,
        cuddlersCount: Int,
        cuddlers: [CuddlerModel]
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

extension ProfileModel: Equatable {}

public struct CuddlerModel {
    public let name: String
    public let imageURL: URL
    public let withDay: Int
    public let gender: GenderModel
    public let birth: Date
    public let kind: String
    public let weight: Double
    public let description: String?
    public let withDate: Date
    public let endDate: Date?
    
    public init(
        name: String,
        imageURL: URL,
        withDay: Int,
        gender: GenderModel,
        birth: Date,
        kind: String,
        weight: Double,
        description: String?,
        withDate: Date,
        endDate: Date?
    ) {
        self.name = name
        self.imageURL = imageURL
        self.withDay = withDay
        self.gender = gender
        self.birth = birth
        self.kind = kind
        self.weight = weight
        self.description = description
        self.withDate = withDate
        self.endDate = endDate
    }
}

extension CuddlerModel: Equatable {}
