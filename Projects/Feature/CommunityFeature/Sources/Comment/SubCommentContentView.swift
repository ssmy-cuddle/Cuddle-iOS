//
//  SubCommentContentView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/4/24.
//

import Foundation
import SwiftUI

import DesignSystem

import Kingfisher

public struct SubCommentContentView: View {
    
    let subComment: SubCommentModel
    
    public init(subComment: SubCommentModel) {
        self.subComment = subComment
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                profileImageView(url: subComment.profileImageURL)
                    .frame(width: 24, height: 24)
                nameText(subComment.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                dateText(createdAt: subComment.createdAt)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                commentView(subComment.text)
                deleteText()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 32)
            .padding(.bottom, 8)
        }
    }
}

extension SubCommentContentView {
    
    @ViewBuilder
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
        Text(name)
            .font(.pretendardBody10)
    }
    
    @ViewBuilder
    private func dateText(createdAt: Date) -> some View {
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
    
    @ViewBuilder
    private func commentView(_ comment: String) -> some View {
        Text(comment)
            .font(.pretendardBody12)
            .frame(alignment: .leading)
            .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
    }
    
    @ViewBuilder
    private func deleteText() -> some View {
        Text("삭제")
            .font(.pretendardBody8)
            .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
    }
}
