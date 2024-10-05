//
//  OAuthLayer+LiveKey.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

import Alamofire
import Dependencies

extension OAuthLayerKey: DependencyKey {
    public static var liveValue = OAuthLayer()
}
