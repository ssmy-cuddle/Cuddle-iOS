//
//  CuddlerProfileInputType.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation

import ProfileFeatureInterface

public enum CuddlerProfileInputType {
    case register
    case edit(CuddlerProfileModel)
    
    public var cuddler: CuddlerProfileModel? {
        switch self {
        case .register: nil
        case let .edit(cuddler): cuddler
        }
    }
}

extension CuddlerProfileInputType {
    
    public var title: String {
        switch self {
        case .register: "프로필 등록"
        case .edit: "프로필 수정"
        }
    }
    
    public var buttonTitle: String {
        switch self {
        case .register: "등록"
        case .edit: "수정완료"
        }
    }
}
