//
//  OriginalClient.swift
//  OriginalClient
//
//  Created by mvldev7 on 9/9/24.
//

import Foundation

import Dependencies
import DependenciesMacros

@DependencyClient
public struct OriginalClient {
    public var list: (_ id: String) async throws -> [CuddleOriginal]
}
