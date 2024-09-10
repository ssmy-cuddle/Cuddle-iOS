//
//  RegisterDailyContentParameter.swift
//  CommunityClient
//
//  Created by mvldev7 on 8/29/24.
//

import Foundation

public struct RegisterDailyContentParameter {
    public let images: [Data]
    public let description: String
    
    public init(images: [Data], description: String) {
        self.images = images
        self.description = description
    }
}
