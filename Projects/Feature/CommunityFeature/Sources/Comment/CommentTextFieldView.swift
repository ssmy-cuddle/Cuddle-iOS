//
//  CommentTextFieldView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/4/24.
//

import Foundation
import SwiftUI

import DesignSystem

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
            replyView(commentType: commentType)
            commentInputView
        }
    }
}

extension CommentTextField {
    @ViewBuilder
    private func replyView(commentType: Comment.CommentType) -> some View {
        if case let .reply(_, name) = commentType {
            HStack {
                Text("\(name) 님에게 답글 다는 중...")
                    .font(.pretendardBody12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
                
                Button(action: { cancelFocus() }) {
                    Text("취소")
                        .font(.pretendardBody10)
                        .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
                        .onTapGesture { cancelFocus() }
                }
                .padding(.horizontal, 16)
            }
            .background(Color(red: 0.91, green: 0.91, blue: 0.91))
        }
    }
    
    @ViewBuilder
    private var commentInputView: some View {
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
                font: .pretendardBody12,
                isEnabled: .constant(true)
            )
            .frame(width: 72)
            .scaledToFit()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 12)
    }
}
