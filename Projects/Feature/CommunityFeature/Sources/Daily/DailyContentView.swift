//
//  DailyContentView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/4/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

import Kingfisher

public struct DailyContentView: View {
    
    @State var scrolledID: URL?
    
    private let dailyContent: DailyContentModel
    private let commentAction: () -> Void
    private let likeAction: () -> Void
    
    public init(
        dailyContent: DailyContentModel,
        commentAction: @escaping () -> Void,
        likeAction: @escaping () -> Void
    ) {
        self.dailyContent = dailyContent
        self.commentAction = commentAction
        self.likeAction = likeAction
    }
    
    var pagingControl: some View {
        HStack(spacing: 3) {
            ForEach(dailyContent.imageURLs, id: \.hashValue) { url in
                if url == scrolledID {
                    Rectangle()
                        .frame(width: 16, height: 3)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 3))
                } else {
                    Circle()
                        .frame(width: 3, height: 3)
                        .foregroundStyle(.black.opacity(0.3))
                }
            }
        }
     }
    
    public var body: some View {
//        GeometryReader { geometry in
        VStack(alignment: .leading, spacing: .zero) {
            HStack(alignment: .center, spacing: 6) {
                KFImage(dailyContent.profileIageURL)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .clipShape(.circle)
                
                Text(dailyContent.nickname)
                    .font(.pretendardBody12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                let components = Calendar.current.dateComponents(
                    [.second],
                    from: dailyContent.createdAt,
                    to: Date()
                )
                
                Text("\(Int(ceil(Double((components.second ?? .zero)) / 60.0)))분전")
                    .font(.pretendardBody12)
                    .foregroundStyle(Color(red: 0.74, green: 0.74, blue: 0.74))
            }
            .padding(.vertical, 6)
            .padding(.leading, 6)
            .padding(.trailing, 14)
                
            ZStack(alignment: .bottom) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(Array(dailyContent.imageURLs), id: \.self) {
                            KFImage($0)
                                .resizable()
                                .aspectRatio(292 / 278, contentMode: .fill)
                        }
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrolledID)
                .scrollIndicators(.hidden)
                .onAppear { scrolledID = dailyContent.imageURLs.first }
                
                pagingControl
                    .padding(.bottom, 6)
            }
            .aspectRatio(292 / 278, contentMode: .fill)
            
            HStack(alignment: .center, spacing: 8) {
                HStack {
                    let likeImage: Image = if dailyContent.isLike {
                        AppResourceAsset.Image.icHeartSignFilled.swiftUIImage
                    } else {
                        AppResourceAsset.Image.icHeartSign.swiftUIImage
                    }
                    
                    likeImage
                        .resizable()
                        .foregroundStyle(dailyContent.isLike ? Color(red: 1, green: 0.39, blue: 0.68) : .black)
                        .frame(width: 24, height: 24)
                    
                    Text(String(dailyContent.likeCounts))
                        .font(.pretendardBody14)
                }
                .onTapGesture { likeAction() }
                
                HStack {
                    AppResourceAsset.Image.icComment.swiftUIImage
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text(String(dailyContent.messageCounts))
                        .font(.pretendardBody14)
                }
                .onTapGesture { commentAction() }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
            
            Text(dailyContent.description)
                .font(.pretendardBody12)
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .padding(.bottom, 14)
            
        }
        .clipShape(.rect(cornerRadius: 5))
        .overlay(
            RoundedRectangle(
                cornerRadius: 5
            )
            .stroke(.black.opacity(0.1), lineWidth: 0.8)
        )
        //        }
    }
}
