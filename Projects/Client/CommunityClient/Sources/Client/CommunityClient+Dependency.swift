//
//  CommunityClient+Dependency.swift
//  CommunityClient
//
//  Created by mvldev7 on 9/21/24.
//

import Foundation

import Dependencies

public extension DependencyValues {
    var communityClient: CommunityClient {
        get { self[CommunityClient.self] }
        set { self[CommunityClient.self] = newValue }
    }
}
