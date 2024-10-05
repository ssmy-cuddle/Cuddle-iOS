//
//  BasicLayer+Dependencies.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

import Dependencies

public enum BasicLayerKey: TestDependencyKey {
    public static var testValue = BasicLayer()
}

public extension DependencyValues {
    var basicLayer: BasicLayer {
        get { self[BasicLayerKey.self] }
        set { self[BasicLayerKey.self] = newValue }
    }
}
