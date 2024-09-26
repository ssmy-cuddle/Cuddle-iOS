//
//  CommentFeature.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation

import BaseFeature
import CommunityClient
import ProfileClient

import ComposableArchitecture

public enum DeleteCommentType: Equatable {
    case comment(UUID)
    case subComment(UUID)
    
    var value: UUID {
        switch self {
        case let .comment(id): id
        case let .subComment(id): id
        }
    }
}

@Reducer
public struct CommentFeature {
    
    @Dependency(\.getCommentListUseCase) private var getCommentListUseCase
    @Dependency(\.registerCommentUseCase) private var registerCommentUseCase
    @Dependency(\.registerSubCommentUseCase) private var registerSubCommentUseCase
    @Dependency(\.getUserProfileUseCase) private var getUserProfileUseCae
    
    @Dependency(\.communityClient) private var communityClient
    
    public enum Action: FeatureAction, BindableAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        case binding(BindingAction<State>)
        
        public enum ViewAction: Equatable {
            case onAppear
            case registrer
            case changeCommentType(CommentType)
            case deleteCommentButtonTapped(DeleteCommentType)
            case deleteComment(UUID)
        }
        public enum InnerAction: Equatable {
            case comments([Comment])
            case updateComments([Comment])
            case updateComment(Comment, Int)
            case user(UserProfile)
            case delete(Comment)
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
        public let id: UUID
        public var commentType: CommentType = .normal
        public var comments: [Comment] = []
        public var writingComment: String = ""
        public var latestAddItem: LatestAddedItem? = nil
        public var user: UserProfile?
        
        @Presents public var deleteComment: UUID?
        
        public init(id: UUID) {
            self.id = id
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .view(action):
                self.reduce(viewAction: action, state: &state)
            case let .inner(action):
                self.reduce(innerAction: action, state: &state)
            default: .none
            }
        }
    }
}

extension CommentFeature {
    
    // MARK: - View
    
    private func reduce(viewAction: Action.ViewAction, state: inout State) -> Effect<Action> {
        switch viewAction {
        case .onAppear:
            self.onAppear(state: &state)
        case .registrer:
            self.register(state: &state)
        case let .changeCommentType(type):
            self.commentType(type, state: &state)
        case let .deleteCommentButtonTapped(comment):
            self.deleteCommentButtonTapped(id: comment.value, state: &state)
        case let .deleteComment(id):
            self.deleteComment(id: id, state: &state)
        }
    }
    
    private func onAppear(state: inout State) -> Effect<Action> {
        .merge(
            .run {
                let comments = try await getCommentListUseCase.execute(
                    parameters: .init(id: UUID())
                )
                return await $0(.inner(.comments(comments)))
            },
            .run {
                let user = try await getUserProfileUseCae.execute()
                return await $0(.inner(.user(user)))
            }
        )
    }
    
    private func reduce(innerAction: Action.InnerAction, state: inout State) -> Effect<Action> {
        switch innerAction {
        case let .comments(comments):
            self.comments(comments, state: &state)
        case let .user(user):
            self.user(user, state: &state)
        case let .updateComment(comment, index):
            self.update(comment: comment, at: index, state: &state)
        case let .updateComments(comments):
            self.update(comments: comments, state: &state)
        case let .delete(comment):
            self.deletedComment(comment, state: &state)
        }
    }
    
    
    private func comments(_ comments: [Comment], state: inout State) -> Effect<Action> {
        state.comments = comments
        return .none
    }
    
    private func update(comments: [Comment], state: inout State) -> Effect<Action> {
        state.comments = comments
        state.latestAddItem = if let id = comments.last?.id {
            .comment(id: id)
        } else {
            nil
        }
        return .none
    }
    
    private func deleteCommentButtonTapped(id: UUID, state: inout State) -> Effect<Action> {
        state.deleteComment = id
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
                )
                return await $0(.inner(.updateComments(comments)))
            }
        case let .reply(id, _):
            return .run {
                let comment = try await registerSubCommentUseCase.execute(
                    parameters: .init(
                        commentID: id,
                        text: localState.writingComment
                    )
                )
                if let index = localState.comments.firstIndex(where: { $0.id == id }) {
                    return await $0(.inner(.updateComment(comment, index)))
                }
            }
        }
    }
    
    private func update(comment: Comment, at index: Int, state: inout State) -> Effect<Action> {
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
    
    private func user(_ user: UserProfile, state: inout State) -> Effect<Action> {
        state.user = user
        return .none
    }
    
    private func deleteComment(id: UUID, state: inout State) -> Effect<Action> {
        .run {
            let deletedComment = try await communityClient.deleteComment(id: id)
            return await $0(.inner(.delete(deletedComment)))
        }
    }
    
    private func deletedComment(_ comment: Comment, state: inout State) -> Effect<Action> {
        state.comments = state.comments.filter { $0.id != comment.id }
        return .none
    }
}
