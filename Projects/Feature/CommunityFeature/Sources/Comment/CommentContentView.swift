//
//  CommentContentView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/4/24.
//

import Foundation
import SwiftUI

import CommunityClient
import DesignSystem

import Kingfisher

public struct CommentContentView: View {
    
    private let comment: Comment
    private let userUUID: UUID
    private let replyButtonTapped: () -> Void
    private let deleteButtonTapped: (DeleteCommentType) -> Void
    
    public init(
        comment: Comment,
        userUUID: UUID,
        replyButtonTapped: @escaping () -> Void,
        deleteButtonTapped: @escaping (DeleteCommentType) -> Void
    ) {
        self.comment = comment
        self.userUUID = userUUID
        self.replyButtonTapped = replyButtonTapped
        self.deleteButtonTapped = deleteButtonTapped
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                profileImageView(url: comment.profileImageURL)
                    .frame(width: 24, height: 24)
                
                nameText(comment.name)
                    .frame(maxWidth: .infinity, alignment: .leading)

                dateText(createdAt: comment.createdAt)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                commentText(comment.text)
                
                HStack(spacing: 8) {
                    replyText { replyButtonTapped() }
                    if comment.userUUID == userUUID {
                        deleteText { deleteButtonTapped(.comment(comment.id)) }
                    }
                }
                .frame(alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 32)
            .padding(.bottom, 8)
            
            subCommentListView(
                comment.subComments,
                userUUID: userUUID
            )
                .padding(.leading, 30)
        }
        .padding(.horizontal, 18)
    }
}

extension CommentContentView {
    
    private func profileImageView(url: URL) -> some View {
        KFImage(url)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(.circle)
            .overlay {
                Circle()
                    .strokeBorder(.white, lineWidth: 2)
            }
    }
    
    @ViewBuilder
    private func nameText(_ name: String) -> some View {
        Text(comment.name)
            .font(.pretendardBody10)
    }
    
    @ViewBuilder
    private func dateText(createdAt: Date) -> some View {
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
    
    @ViewBuilder
    private func commentText(_ comment: String) -> some View {
        Text(comment)
            .font(.pretendardBody12)
            .frame(alignment: .leading)
            .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
    }
    
    @ViewBuilder
    private func replyText(onTapGesture: @escaping () -> Void) -> some View {
        Text("답글 달기")
            .font(.pretendardBody8)
            .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
            .onTapGesture { onTapGesture() }
    }
    
    @ViewBuilder
    private func deleteText(onTapGesture: @escaping () -> Void) -> some View {
        Text("삭제")
            .font(.pretendardBody8)
            .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
            .onTapGesture { onTapGesture() }
    }
    
    @ViewBuilder
    private func subCommentListView(
        _ subComments: [SubComment],
        userUUID: UUID
    ) -> some View {
        LazyVStack(spacing: 4) {
            ForEach(subComments, id: \.id) { subComment in
                SubCommentContentView(
                    subComment: subComment,
                    userUUID: userUUID,
                    onDeleteButtonTap: { deleteButtonTapped(.subComment($0)) }
                )
            }
        }
    }
}
