//
//  Comment.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import BaseFeature
import CommunityDomain

import ComposableArchitecture

@Reducer
public struct Comment {
    
    @Dependency(\.getCommentListUseCase) private var getCommentListUseCase
    @Dependency(\.registerCommentUseCase) private var registerCommentUseCase
    
    public enum Action: FeatureAction, BindableAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
        
        public enum ViewAction: Equatable {
            case onAppear
            case registrer
        }
        public enum InnerAction: Equatable {
            case comments([CommentModel])
        }
        public enum DelegateAction: Equatable {}
    }
    
    @ObservableState
    public struct State: Equatable {
        public var comments: [CommentModel] = []
        public var writingComment: String = ""
        
        public init() {}
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.onAppear): onAppear(state: &state)
            case .view(.registrer): register(state: &state)
            case let .inner(.comments(comments)): self.comments(comments, state: &state)
            default: .none
            }
        }
    }
}

extension Comment {
    
    private func onAppear(state: inout State) -> Effect<Action> {
        .run {
            let comments = try await getCommentListUseCase.execute(
                parameters: .init(id: UUID())
            ).map { $0.asModel }
            return await $0(.inner(.comments(comments)))
        }
    }
    
    private func comments(_ comments: [CommentModel], state: inout State) -> Effect<Action> {
        state.comments = comments
        return .none
    }
    
    private func register(state: inout State) -> Effect<Action> {
        let localState = state
        state.writingComment = ""
        return .run {
            let comments = try await registerCommentUseCase.execute(
                parameters: .init(
                    id: UUID(),
                    commtentText: localState.writingComment
                )
            ).map { $0.asModel }
            return await $0(.inner(.comments(comments)))
        }
    }
}
