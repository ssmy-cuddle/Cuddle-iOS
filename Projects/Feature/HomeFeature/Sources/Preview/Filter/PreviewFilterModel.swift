//
//  PreviewFilterModel.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/18/24.
//

import Foundation

public struct PreviewFilterModel: Equatable {
    public let previewType: PreviewType
    public let isSelected: Bool
    
    public init(previewType: PreviewType, isSelected: Bool) {
        self.previewType = previewType
        self.isSelected = isSelected
    }
}
