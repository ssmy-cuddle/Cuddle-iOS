//
//  UpdateCuddlerProfileParameter.swift
//  ProfileClient
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

import BaseClient

public struct UpdateCuddlerProfileParameter {
    public let name: String?
    public let image: Data?
    public let gender: Gender?
    public let kind: String?
    public let weight: Double?
    public let description: String?
    public let withDate: Date?
    public let endDate: Date?
    
    public init(
        name: String?,
        image: Data?,
        gender: Gender?,
        kind: String?,
        weight: Double?,
        description: String?,
        withDate: Date?,
        endDate: Date?
    ) {
        self.name = name
        self.image = image
        self.gender = gender
        self.kind = kind
        self.weight = weight
        self.description = description
        self.withDate = withDate
        self.endDate = endDate
    }
}
