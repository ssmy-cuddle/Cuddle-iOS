//
//  Dependency+External.swift
//  Plugin
//
//  Created by mvldev7 on 7/7/24.
//

import Foundation

import ProjectDescription

public enum External {
    case alamofire
    case composableArchitecture
    case kingfisher
    case lottie
    case navigationTransitions
    case kakaoSDK
    case popupView
}

extension External: CaseIterable {}

extension External: TargetDependencyCovertible {
    public var targetDependency: TargetDependency {
        switch self {
        case .alamofire: .external(name: "Alamofire")
        case .composableArchitecture: .external(name: "ComposableArchitecture")
        case .kingfisher: .external(name: "Kingfisher")
        case .lottie: .external(name: "Lottie")
        case .navigationTransitions: .external(name: "NavigationTransitions")
        case .kakaoSDK: .external(name: "KakaoSDK")
        case .popupView: .external(name: "PopupView")
        }
    }
}
