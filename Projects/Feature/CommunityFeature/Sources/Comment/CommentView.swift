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

    @FocusState private var isFocused: Bool
    @State private var detent: PresentationDetent = .medium
    @State private var scrollPosition: Int?
    @StateObject private var keyboardObserver = KeyboardObserver()
    
    public init(store: StoreOf<Comment>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
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
                    .scrollPosition(id: $scrollPosition)
                    .animation(.default, value: scrollPosition)
                    .onChange(of: store.latestAddItem) {
                        switch $0 {
                        case let .comment(id):
                            withAnimation {
                                proxy.scrollTo(id, anchor: .top)
                            }
                            proxy.scrollTo(id, anchor: .top)
                        case let .subComment(commentID, _):
                            withAnimation {
                                proxy.scrollTo(commentID, anchor: .bottom)
                            }
                        case .none:
                            return
                        }
                    }
                }
                CommentTextField(
                    comment: store.binding(
                        get: \.writingComment,
                        send: { .binding(.set(\.writingComment, $0)) }
                    ),
                    commentType: .constant(store.commentType),
                    isFocused: $isFocused,
                    register: { store.send(.view(.registrer)) },
                    cancelFocus: {
                        store.send(.view(.changeCommentType(.normal)))
                        isFocused = false
                    }
                )
            }
            .padding(.vertical, 12)
            .onAppear { store.send(.view(.onAppear)) }
            .onChange(of: keyboardObserver.keyboardHeight) { (height: CGFloat) in
                scrollPosition = (scrollPosition ?? 0) + Int(height)
            }
        }
        .presentationDetents([.medium, .large], selection: $detent)
    }
}

public struct CommentTextField: View {
    
    @Binding private var comment: String
    @Binding private var commentType: Comment.CommentType
    
    private var isFocused: FocusState<Bool>.Binding
    
    private let register: () -> Void
    private let cancelFocus: () -> Void
    
    public init(
        comment: Binding<String>,
        commentType: Binding<Comment.CommentType>,
        isFocused: FocusState<Bool>.Binding,
        register: @escaping () -> Void,
        cancelFocus: @escaping () -> Void
    ) {
        self._comment = comment
        self._commentType = commentType
        self.isFocused = isFocused
        self.register = register
        self.cancelFocus = cancelFocus
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            if case let .reply(_, name) = commentType {
                HStack {
                    Text("\(name) 님에게 답글 다는 중...")
                        .font(.pretendardBody12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
                    
                    Button(action: {}) {
                        Text("취소")
                            .font(.pretendardBody10)
                            .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
                            .onTapGesture { cancelFocus() }
                    }
                    .padding(.horizontal, 16)
                }
                .background(Color(red: 0.91, green: 0.91, blue: 0.91))
            }
            
            HStack(spacing: 6) {
                TextField("댓글을 입력하세요.", text: $comment)
                    .focused(isFocused)
                    .font(.pretendardBody12)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .strokeBorder(Color(red: 0.91, green: 0.91, blue: 0.91))
                    }
                    .frame(maxWidth: .infinity)
                
                CuddleTextButton(
                    action: { register() },
                    theme: .primary(.custom(Color(red: 1, green: 0.45, blue: 0.45))),
                    text: "등록",
                    font: .pretendardBody12
                )
                .frame(width: 72)
                .scaledToFit()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
        }
    }
}

public struct CommentContentView: View {
    
    private let comment: CommentModel
    private let replyButtonTapped: () -> Void
    
    public init(comment: CommentModel, replyButtonTapped: @escaping () -> Void) {
        self.comment = comment
        self.replyButtonTapped = replyButtonTapped
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                KFImage(comment.profileImageURL)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(.circle)
                    .overlay {
                        Circle()
                            .strokeBorder(.white, lineWidth: 2)
                    }
                
                Text(comment.name)
                    .font(.pretendardBody10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let components = Calendar.current.dateComponents(
                    [.second],
                    from: comment.createdAt,
                    to: Date()
                )
                
                Text("\(Int(ceil(Double((components.second ?? .zero)) / 60.0)))분전")
                    .font(.pretendardBody10)
                    .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                    .padding(.trailing, 4)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(comment.text)
                    .font(.pretendardBody12)
                    .frame(alignment: .leading)
                    .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                
                
                HStack(spacing: 8) {
                    Text("답글 달기")
                        .font(.pretendardBody8)
                        .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                        .onTapGesture { replyButtonTapped() }
                    
                    Text("삭제")
                        .font(.pretendardBody8)
                        .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                }
                .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 32)
            .padding(.bottom, 8)
            
            LazyVStack(spacing: 4) {
                ForEach(comment.subComments, id: \.id) {
                    SubCommentContentView(subComment: $0)
                }
            }
            .padding(.leading, 30)
        }
        .padding(.horizontal, 18)
    }
}

public struct SubCommentContentView: View {
    
    let subComment: SubCommentModel
    
    public init(subComment: SubCommentModel) {
        self.subComment = subComment
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                KFImage(subComment.profileImageURL)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(.circle)
                    .overlay {
                        Circle()
                            .strokeBorder(.white, lineWidth: 2)
                    }
                
                Text(subComment.name)
                    .font(.pretendardBody10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let components = Calendar.current.dateComponents(
                    [.second],
                    from: subComment.createdAt,
                    to: Date()
                )
                
                Text("\(Int(ceil(Double((components.second ?? .zero)) / 60.0)))분전")
                    .font(.pretendardBody10)
                    .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                    .padding(.trailing, 4)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(subComment.text)
                    .font(.pretendardBody12)
                    .frame(alignment: .leading)
                    .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                
                
                HStack(spacing: 8) {                    
                    Text("삭제")
                        .font(.pretendardBody8)
                        .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                }
                .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 32)
            .padding(.bottom, 8)
        }
    }
}

public struct CommentViewDetent: CustomPresentationDetent {
    
    private static var keyboardObserver = KeyboardObserver()
    
    public static func height(
        in context: Context
    ) -> CGFloat? {
//        context.maxDetentValue * 0.9 - keyboardObserver.keyboardHeight +
//        (keyboardObserver.isKeyboardVisible ? context.safeAreaInsets.bottom : .zero)
        
        keyboardObserver.isKeyboardVisible ? context.maxDetentValue * 0.4 : context.maxDetentValue * 0.8
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
