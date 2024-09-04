//
//  CommentView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/1/24.
//

import Foundation
import SwiftUI

import DesignSystem
import UIComponent

import ComposableArchitecture
import Kingfisher

public struct CommentView: View {
    
    let store: StoreOf<Comment>
    
    @State private var detent: PresentationDetent = .medium
    @State private var scrollPosition: Int?
    
    @FocusState private var isFocused: Bool
    
    public init(store: StoreOf<Comment>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        commentListView(
                            store.comments,
                            proxy: proxy
                        )
                    }
                    .onChange(of: store.latestAddItem) { _, latestAdditem in
                        switch latestAdditem {
                        case let .comment(id):
                            withAnimation { proxy.scrollTo(id, anchor: .top) }
                        case let .subComment(commentID, _):
                            withAnimation { proxy.scrollTo(commentID, anchor: .bottom) }
                        case .none:
                            return
                        }
                    }
                }
                
                commentTextField(
                    comment: store.binding(
                        get: \.writingComment,
                        send: { .binding(.set(\.writingComment, $0)) }
                    ),
                    commentType: .constant(store.commentType),
                    onRegister: {
                        store.send(.view(.registrer))
                    },
                    onCancelFocus: {
                        store.send(.view(.changeCommentType(.normal)))
                        isFocused = false
                    }
                )
            }
            .padding(.vertical, 12)
            .onAppear { store.send(.view(.onAppear)) }
        }
        .presentationDetents([.medium, .large], selection: $detent)
    }
}

extension CommentView {
    
    private func commentListView(
        _ comments: [CommentModel],
        proxy: ScrollViewProxy
    ) -> some View {
        LazyVStack(spacing: 4) {
            ForEach(store.comments, id: \.id) { comment in
                CommentContentView(
                    comment: comment,
                    replyButtonTapped: {
                        store.send(.view(.changeCommentType(.reply(id: comment.id, name: comment.name))))
                        isFocused = true
                        detent = .large
                        withAnimation {
                            proxy.scrollTo(comment.id, anchor: .center)
                        }
                    }
                )
                .id(comment.id)
            }
        }
        .padding(.top, 40)
    }
    
    private func commentTextField(
        comment: Binding<String>,
        commentType: Binding<Comment.CommentType>,
        onRegister: @escaping () -> Void,
        onCancelFocus: @escaping () -> Void
    ) -> some View {
        CommentTextField(
            comment: comment,
            commentType: commentType,
            isFocused: $isFocused,
            register: { onRegister() },
            cancelFocus: { onCancelFocus() }
        )
    }
}
