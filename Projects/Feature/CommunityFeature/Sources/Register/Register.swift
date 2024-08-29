//
//  Register.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import UIKit

import CommunityDomain

import ComposableArchitecture

@Reducer
public struct Register {
    
    @Dependency(\.registerDailyContentUseCase) private var registerDailyContentUseCase
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case removeImage(UIImage)
        case back
        case confirm
        case didEndRegister
    }
    
    @ObservableState
    public struct State: Equatable {
        public var title: String = ""
        public var descriotion: String = ""
        public var selectedImages: [UIImage] = []
        
        public var isLoading: Bool = false
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .removeImage(image):
                state.selectedImages = state.selectedImages.filter {
                    $0 != image
                }
                return .none
            case .back:
                return .none
            case .confirm:
                return register(state: &state)
            case .didEndRegister: return registered(
                for: nil,
                state: &state
            )
            case .binding(\.title):
                return .none
            case .binding:
                return .none
            }
        }
    }
}

extension Register {
    
    private func register(state: inout State) -> Effect<Action> {
        state.isLoading = true
        let localState = state
        return .run { send in
            let _ = try await registerDailyContentUseCase.execute(
                parameters: RegisterDailyContentParameter(
                    images: localState.selectedImages.compactMap { $0.pngData() },
                    description: localState.descriotion
                )
            )
            await send(.didEndRegister)
        }
    }
    
    private func registered(
        for content: DailyContentModel? = nil,
        state: inout State
    ) -> Effect<Action> {
        state.isLoading = false
        return .none
    }
}
