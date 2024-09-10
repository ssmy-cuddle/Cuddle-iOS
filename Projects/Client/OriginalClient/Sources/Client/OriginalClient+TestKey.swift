//
//  OriginalClient+TestKey.swift
//  OriginalClient
//
//  Created by mvldev7 on 9/9/24.
//

import Foundation

import Dependencies

extension OriginalClient: TestDependencyKey {
    
    // TODO: liveValue 구현 이후 제거
    public static var testValue: OriginalClient = OriginalClient(
        list: { _ in try await Self.list() }
    )
    
    private static func list() async throws -> [CuddleOriginal] {
        try await Task.sleep(for: .milliseconds(1000))
        return [
            MockCuddleOriginal.cuddleOpen2,
            MockCuddleOriginal.cuddleOpen
        ]
    }
}
