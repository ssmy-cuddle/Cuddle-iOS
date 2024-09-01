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
    
    @StateObject private var keyboardObserver = KeyboardObserver()
    @State private var contentHeight: CGFloat = .zero
    
    public init(store: StoreOf<Comment>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack {
                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(store.comments, id: \.id) {
                            CommentContentView(comment: $0)
                        }
                    }
                    .padding(.top, 40)
                }
                CommentTextField(
                    comment: store.binding(
                        get: \.writingComment,
                        send: { .binding(.set(\.writingComment, $0)) }
                    ),
                    register: { store.send(.view(.registrer)) }
                )
            }
            .padding(.vertical, 12)
            .onAppear { store.send(.view(.onAppear)) }
        }
    }
}

public struct CommentTextField: View {
    
    @Binding private var comment: String
    private let register: () -> Void
    
    public init(comment: Binding<String>, register: @escaping () -> Void) {
        self._comment = comment
        self.register = register
    }
    
    public var body: some View {
        HStack(spacing: 6) {
            TextField("댓글을 입력하세요.", text: $comment)
                .font(.pretendardBody12)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
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

public struct CommentContentView: View {
    
    let comment: CommentModel
    
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
                    Text("답글 달기")
                        .font(.pretendardBody8)
                        .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                    
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
