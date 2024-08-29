//
//  UseCase.swift
//  BaseDomain
//
//  Created by mvldev7 on 8/27/24.
//

import Foundation

public protocol UseCase {
    associatedtype Parameter
    associatedtype Result
    
    func execute(parameters: Parameter) async throws -> Result
}

