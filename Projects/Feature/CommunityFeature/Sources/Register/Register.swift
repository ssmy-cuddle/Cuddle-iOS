//
//  Register.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import UIKit

import ComposableArchitecture

@Reducer
public struct Register {
    
    public init() {
        print("Register init")
    }
    
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
                state.isLoading = true
                return .run { send in
                    try await Task.sleep(for: .seconds(2))
                    await send(.didEndRegister)
                }
            case .didEndRegister:
                state.isLoading = false
                return .none
            case .binding(\.title):
                print("title \(state.title)")
                return .none
            case .binding:
                return .none
            }
        }
    }
}
