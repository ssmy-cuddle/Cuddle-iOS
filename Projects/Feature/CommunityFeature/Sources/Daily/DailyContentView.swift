//
//  DailyContentView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/4/24.
//

import Foundation
import SwiftUI

import DesignSystem

import Kingfisher

public struct DailyContentView: View {
    
    @State var scrolledID: Int = .zero
    
    let dailyContent: DailyContentModel
    
    public var body: some View {
//        GeometryReader { geometry in
        VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 6) {
                    KFImage(dailyContent.profileIageURL)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(.rect(cornerRadius: 20))
                    
                    Text(dailyContent.nickname)
                        .font(.pretendardBody12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("2분전")
                        .font(.pretendardBody12)
                        .foregroundStyle(Color(red: 0.74, green: 0.74, blue: 0.74))
                }
                .padding(.vertical, 6)
                .padding(.leading, 6)
                .padding(.trailing, 14)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(Array(dailyContent.imageURLs.enumerated()), id: \.offset) {
                            KFImage($0.element)
                                .resizable()
                                .frame(width: 390, height: 390 * (292 / 278))
                                .aspectRatio(292 / 278, contentMode: .fill)
                                .id($0.offset)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                
                
                HStack(spacing: 8) {
                    Text(String(dailyContent.likeCounts))
                        .font(.pretendardBody14)
                    Text(String(dailyContent.messageCounts))
                        .font(.pretendardBody14)
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
