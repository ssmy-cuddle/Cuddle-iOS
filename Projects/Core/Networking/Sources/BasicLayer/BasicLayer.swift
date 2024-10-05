//
//  BasicLayer.swift
//  Networking
//
//  Created by mvldev7 on 9/28/24.
//

import Foundation

public final class BasicLayer: Networking {
    public init() {
        super.init(
            interceptor: BasicAuthorizationRequestInterceptor()
        )
    }
}
