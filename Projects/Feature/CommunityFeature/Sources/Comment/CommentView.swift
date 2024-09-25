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

import CommunityClient

import ComposableArchitecture
import Kingfisher
import PopupView

public struct CommentView: View {
    
    @Bindable private var store: StoreOf<CommentFeature>
    
    @State private var detent: PresentationDetent = .medium
    @State private var scrollPosition: Int?
    
    @FocusState private var isFocused: Bool
    
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    public init(store: StoreOf<CommentFeature>) {
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
        .popup(item: $store.deleteComment) { commentID in
            ConfirmPopupView(
                title: "이 댓글을 삭제 하시겠어요?",
                confirmAction: {
                    store.send(.view(.deleteComment(commentID)))
                },
                cancelAction: {}
            )
        } customize: {
            $0.type(.floater(verticalPadding: 20, horizontalPadding: 20, useSafeAreaInset: true))
                .position(.center)
                .closeOnTapOutside(false)
                .isOpaque(true)
                .appearFrom(.centerScale)
                .animation(.easeInOut(duration: 0))
        }
        .onChange(of: keyboardResponder.isKeyboardVisible) { _, isKeyboardVisible in
            if isKeyboardVisible { detent = .large }
        }
    }
}

extension CommentView {
    
    private func commentListView(
        _ comments: [Comment],
        proxy: ScrollViewProxy
    ) -> some View {
        LazyVStack(spacing: 4) {
            ForEach(store.comments, id: \.id) { comment in
                CommentContentView(
                    comment: comment,
                    userUUID: store.user?.id ?? UUID(),
                    replyButtonTapped: {
                        store.send(.view(.changeCommentType(.reply(id: comment.id, name: comment.name))))
                        isFocused = true
                        detent = .large
                        withAnimation {
                            proxy.scrollTo(comment.id, anchor: .center)
                        }
                    },
                    deleteButtonTapped: {
                        store.send(.view(.deleteCommentButtonTapped(.comment(comment.id))))
                    }
                )
                .id(comment.id)
            }
        }
        .padding(.top, 40)
    }
    
    private func commentTextField(
        comment: Binding<String>,
        commentType: Binding<CommentFeature.CommentType>,
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
