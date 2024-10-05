//
//  OAuthLayer.swift
//  Networking
//
//  Created by mvldev7 on 9/27/24.
//

import Foundation

public final class OAuthLayer: Networking {
    public init() {
        super.init(
            interceptor: OAuthRequestInterceptor()
        )
    }
}

