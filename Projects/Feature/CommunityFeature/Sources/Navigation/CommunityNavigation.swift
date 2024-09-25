//
//  CommunityNavigation.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct CommunityNavigation {
    
    private static var rootPath: Path.State {
        Path.State.main(CommunityFeature.State(isRefreshRequired: true))
    }
    
    public init() {}
    
    @ObservableState
    public struct State {
        public var path = StackState<Path.State>(
            [.main(.init(isRefreshRequired: true))]
        )
        @Presents var comment: CommentFeature.State?
        @Presents var deleteComment: UUID?
        
        public init() {}
    }
    
    public enum Action {
        case path(StackActionOf<Path>)
        case popToRoot
        case comment(PresentationAction<CommentFeature.Action>)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .path(.element(_, .main(action))):
                self.reduce(mainAction: action, state: &state)
            case let .path(.element(_, .register(action))):
                self.reduce(registerAction: action, state: &state)
            case .popToRoot:
                self.popToRoot(state: &state)
            default:
                .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$comment, action: \.comment) {
            CommentFeature()
        }
    }
}

// MARK: - Path
extension CommunityNavigation {
    
    @Reducer
    public enum Path {
        case main(CommunityFeature)
        case register(RegisterFeature)
    }
}

extension CommunityNavigation {
    
    // MARK: - Main
    
    private func reduce(mainAction: CommunityFeature.Action, state: inout State) -> Effect<Action> {
        switch mainAction {
        case .view(.registerButtonTapped):
            self.registerButtonTapped(state: &state)
        case let .daily(.view(.writeComment(id))):
            self.writeCommentButtonTapped(id: id, state: &state)
        default:
            .none
        }
    }
    
    private func registerButtonTapped(state: inout State) -> Effect<Action> {
        state.path.append(.register(.init()))
        return .none
    }
    
    private func writeCommentButtonTapped(id: UUID, state: inout State) -> Effect<Action> {
        state.comment = CommentFeature.State(id: id)
        return .none
    }
    
    // MARK: - Register
    
    private func reduce(registerAction: RegisterFeature.Action, state: inout State) -> Effect<Action> {
        switch registerAction {
        case .view(.backButtomTapped):
            self.backButtonTapped(state: &state)
        case .inner(.registered):
            self.dailyRegistered(state: &state)
        default:
            .none
        }
    }
    
    private func backButtonTapped(state: inout State) -> Effect<Action> {
        state.path.removeLast()
        return .none
    }
    
    private func dailyRegistered(state: inout State) -> Effect<Action> {
        state.path.removeAll()
        state.path.append(.main(.init(isRefreshRequired: true)))
        return .none
    }
    
    // MARK: - PopToRoot
    
    private func popToRoot(state: inout State) -> Effect<Action> {
        state.path.removeAll()
        state.path.append(CommunityNavigation.rootPath)
        return .none
    }
}
