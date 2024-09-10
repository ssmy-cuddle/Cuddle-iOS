//
//  OriginalClient+Preview.swift
//  HomeFeatureTesting
//
//  Created by mvldev7 on 9/10/24.
//

import Foundation

import OriginalClient

import Dependencies

extension OriginalClient {
    
    public static var previewValue = OriginalClient(
        list: { _ in try await Self.list() }
    )
    
    private static func list() async throws -> [CuddleOriginal] {
        try await Task.sleep(for: .milliseconds(2000))
        return [
            MockCuddleOriginal.cuddleOpen2,
            MockCuddleOriginal.cuddleOpen
        ]
    }
}
