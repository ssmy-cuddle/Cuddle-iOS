//
//  CuddlerProfileInputType.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation

public enum CuddlerProfileInputType {
    case register
    case edit(CuddlerModel)
    
    public var title: String {
        switch self {
        case .register: "프로필 등록"
        case .edit: "프로필 수정"
        }
    }
    
    public var cuddler: CuddlerModel? {
        switch self {
        case .register: nil
        case let .edit(cuddler): cuddler
        }
    }
}
