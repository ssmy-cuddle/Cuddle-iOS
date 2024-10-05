//
//  BasicLayer+LiveKey.swift
//  Networking
//
//  Created by mvldev7 on 9/28/24.
//

import Foundation

import Dependencies

extension BasicLayerKey: DependencyKey {
    public static var liveValue = BasicLayer()
}
