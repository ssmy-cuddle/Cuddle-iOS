//
//  Content.swift
//  Cuddle
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation
import SwiftUI

import BaseFeature
import UIComponent

import AuthenticationFeature
import CommunityFeature
import HomeFeature
import ProfileFeature

import ComposableArchitecture

@Reducer
public struct Content {
    
    @ObservableState
    public struct State {
        var navigationTabs: [NavigationTabType] = NavigationTabType.allCases
        var contentType: NavigationTabType = .default
        var isTabBarVisible: Bool = true
        
        var profile: ProfileNavigation.State = .init()
    }
    
    public enum Action: FeatureAction {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        case home(HomeNavigation)
        case profile(ProfileNavigation.Action)

        public enum ViewAction: Equatable {
            case changeTab(NavigationTabType)
            case changeTabBarVisible(Bool)
        }
        public enum InnerAction: Equatable {}
        public enum DelegateAction: Equatable {}
    }
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.profile, action: \.profile) { ProfileNavigation() }
        Reduce { state, action in
            switch action {
            case let .view(action):
                switch action {
                case let .changeTab(contentType):
                    state.contentType = contentType
                    return .none
                case let .changeTabBarVisible(isVisible):
                    state.isTabBarVisible = isVisible
                    return .none
                }
            default:
                return .none
            }
        }
    }
}
