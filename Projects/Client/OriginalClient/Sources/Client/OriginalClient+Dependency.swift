//
//  OriginalClient+Dependency.swift
//  OriginalClient
//
//  Created by mvldev7 on 9/9/24.
//

import Foundation

import Dependencies

public extension DependencyValues {
    var originalClient: OriginalClient {
        get { self[OriginalClient.self] }
        set { self[OriginalClient.self] = newValue }
    }
}
