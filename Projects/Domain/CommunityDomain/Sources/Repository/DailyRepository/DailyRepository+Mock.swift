//
//  DailyRepository+Mock.swift
//  CommunityDomain
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public struct MockDailyRepository: DailyRepository {
    
    public static var isRegisterd: Bool = false
    
    public init() {}
    
    public func dailys() async throws -> [DailyContent] {
        try await Task.sleep(for: .milliseconds(1000))
        return (Self.isRegisterd ? [MockDailyContent.paduck] : []) +
        [
            MockDailyContent.ggeonu,
            MockDailyContent.ggeonu1,
            MockDailyContent.ggeonu2,
            MockDailyContent.ggeonu3,
            MockDailyContent.ggeonu4,
        ]
    }
    
    public func register(
        parameters: RegisterDailyContentParameter
    ) async throws -> DailyContent {
        MockDailyRepository.isRegisterd = true
        try await Task.sleep(for: .milliseconds(1000))
        return MockDailyContent.paduck
    }
}
