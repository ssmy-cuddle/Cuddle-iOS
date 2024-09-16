//
//  RegisterFeature.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import UIKit

import BaseFeature
import CommunityClient

import ComposableArchitecture

@Reducer
public struct RegisterFeature {
    
    @Dependency(\.registerDailyContentUseCase) private var registerDailyContentUseCase
    
    public enum Action: BindableAction, FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
        
        public enum ViewAction: Equatable {
            case backButtomTapped
            case confrimButtonTapped
            case imageRemoveButtonTapped(UIImage)
        }
        public enum InnerAction: Equatable {
            case isLoading(Bool)
            case registered
        }
        public enum DelegateAction: Equatable {}
        
    }
    
    @ObservableState
    public struct State: Equatable {
        public var title: String = ""
        public var descriotion: String = ""
        public var selectedImages: [UIImage] = []
        public var isLoading: Bool = false
        
        public var isConfirmButtonEnabled: Bool {
            !selectedImages.isEmpty && !descriotion.isEmpty
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .view(action):
                self.reduce(viewAction: action, state: &state)
            case let .inner(action):
                self.reduce(innerAction: action, state: &state)
            default:
                .none
            }
        }
    }
}

extension RegisterFeature {
    
    // MARK: View
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .backButtomTapped:
            self.backButtonTapped(state: &state)
        case let .imageRemoveButtonTapped(image):
            self.removeImageButtonTapped(image: image, state: &state)
        case .confrimButtonTapped:
            self.confirmButtonTapped(state: &state)
        }
    }
    
    private func backButtonTapped(state: inout State) -> Effect<Action> {
        .none
    }
    
    private func removeImageButtonTapped(image: UIImage, state: inout State) -> Effect<Action> {
        state.selectedImages = state.selectedImages.filter { $0 != image }
        return .none
    }
    
    private func confirmButtonTapped(state: inout State) -> Effect<Action> {
        let localState = state
        return .concatenate(
            .run { await $0(.inner(.isLoading(true))) },
            .run {
                let _ = try await registerDailyContentUseCase.execute(
                    parameters: RegisterDailyContentParameter(
                        images: localState.selectedImages.compactMap { $0.pngData() },
                        description: localState.descriotion
                    )
                )
                return await $0(.inner(.registered))
            },
            .run { await $0(.inner(.isLoading(false))) }
        )
    }
    
    // MARK: Inner
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        switch innerAction {
        case let .isLoading(isLoading):
            self.isLoading(isLoading, state: &state)
        case .registered:
            self.registered(for: nil, state: &state)
        }
    }

    private func isLoading(_ isLoading: Bool, state: inout State) -> Effect<Action> {
        state.isLoading = isLoading
        return .none
    }
    
    private func registered(for content: DailyContentModel? = nil, state: inout State) -> Effect<Action> {
        .none
    }
}
