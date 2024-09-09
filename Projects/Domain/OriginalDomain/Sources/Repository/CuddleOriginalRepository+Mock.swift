//
//  CuddleOriginalRepository+Mock.swift
//  OriginalDomain
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

public struct MockCuddleOriginalRepository: CuddleOriginalRepository {
    public func list() async throws -> [CuddleOriginal] {
        try await Task.sleep(for: .milliseconds(2000))
        return [
            MockCuddleOriginal.cuddleOpen2,
            MockCuddleOriginal.cuddleOpen
        ]
    }
}
