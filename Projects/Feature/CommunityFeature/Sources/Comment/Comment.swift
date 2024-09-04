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
    @Dependency(\.registerSubCommentUseCase) private var registerSubCommentUseCase
    
    public enum Action: FeatureAction, BindableAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
        
        public enum ViewAction: Equatable {
            case onAppear
            case registrer
            case changeCommentType(CommentType)
        }
        public enum InnerAction: Equatable {
            case comments([CommentModel])
            case updateComments([CommentModel])
            case updateComment(CommentModel, Int)
        }
        public enum DelegateAction: Equatable {}
    }
    
    public enum CommentType: Equatable {
        case normal
        case reply(id: UUID, name: String)
    }
    
    public enum LatestAddedItem: Equatable {
        case comment(id: UUID)
        case subComment(commentID: UUID, subCommentID: UUID)
    }
    
    @ObservableState
    public struct State: Equatable {
        public var commentType: CommentType = .normal
        public var comments: [CommentModel] = []
        public var writingComment: String = ""
        public var latestAddItem: LatestAddedItem? = nil
        
        public init() {}
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.onAppear): onAppear(state: &state)
            case .view(.registrer): register(state: &state)
            case let .view(.changeCommentType(type)): commentType(type, state: &state)
            case let .inner(.comments(comments)): self.comments(comments, state: &state)
            case let .inner(.updateComments(comments)): self.update(comments: comments, state: &state)
            case let .inner(.updateComment(comment, index)): self.update(comment: comment, at: index, state: &state)
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
    
    private func update(comments: [CommentModel], state: inout State) -> Effect<Action> {
        state.comments = comments
        state.latestAddItem = if let id = comments.last?.id {
            .comment(id: id)
        } else {
            nil
        }
        return .none
    }
    
    private func register(state: inout State) -> Effect<Action> {
        let localState = state
        state.writingComment = ""
        switch state.commentType {
        case .normal:
            return .run {
                let comments = try await registerCommentUseCase.execute(
                    parameters: .init(
                        id: UUID(),
                        commtentText: localState.writingComment
                    )
                ).map { $0.asModel }
                return await $0(.inner(.updateComments(comments)))
            }
        case let .reply(id, _):
            return .run {
                let comment = try await registerSubCommentUseCase.execute(
                    parameters: .init(
                        commentID: id,
                        text: localState.writingComment
                    )
                ).asModel
                if let index = localState.comments.firstIndex(where: { $0.id == id }) {
                    return await $0(.inner(.updateComment(comment, index)))
                }
            }
        }
    }
    
    private func update(comment: CommentModel, at index: Int, state: inout State) -> Effect<Action> {
        var localState = state
        localState.comments[index] = comment
        state.comments = localState.comments
        state.latestAddItem = .subComment(commentID: localState.comments[index].id, subCommentID: localState.comments[index].subComments.last!.id)
        state.commentType = .normal
        return .none
    }
    
    private func commentType(_ commentType: CommentType, state: inout State) -> Effect<Action> {
        state.commentType = commentType
        return .none
    }
}
