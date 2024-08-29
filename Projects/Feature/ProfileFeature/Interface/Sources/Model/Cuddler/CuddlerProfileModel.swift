//
//  CuddlerProfileModel.swift
//  ProfileFeatureInterface
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseFeature

public struct CuddlerProfileModel {
    public let id: UUID
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
        id: UUID,
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
        self.id = id
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



extension CuddlerProfileModel: Equatable {}
