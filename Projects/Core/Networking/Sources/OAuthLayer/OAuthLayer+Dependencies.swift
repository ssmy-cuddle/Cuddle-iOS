//
//  OAuthLayer+Dependencies.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

import Dependencies

public enum OAuthLayerKey: TestDependencyKey {
    public static var testValue = OAuthLayer()
}

public extension DependencyValues {
    var oAuthLayer: OAuthLayer {
        get { self[OAuthLayerKey.self] }
        set { self[OAuthLayerKey.self] = newValue }
    }
}
