//
//  WalkmateContentView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/18/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

import Kingfisher

public struct WaltmateContentView: View {
    
    let waltmate: WaltmateContentModel
    
    var startDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter.string(from: waltmate.startDate)
    }
    
    public init(waltmate: WaltmateContentModel) {
        self.waltmate = waltmate
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                KFImage(waltmate.thumbnailURL)
                    .resizable()
                    .frame(width: 54, height: 54)
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 4))
                
                VStack(alignment: .leading, spacing: .zero) {
                     HStack {
                        Text(waltmate.title)
                            .font(.pretendardTitle12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                         
                         Text("2분전")
                             .font(.pretendardBody12)
                             .foregroundStyle(Color(red: 0.74, green: 0.74, blue: 0.74))
                    }
                    
                    Text(waltmate.description)
                        .font(.pretendardBody10)
                        .lineLimit(1)
                        .padding(.top, 6)
                        .padding(.bottom, 8)
                    
                    HStack(alignment: .center, spacing: 8) {
                        HStack(spacing: 4) {
                            AppResourceAsset.Image.icWalkmatePoint.swiftUIImage
                                .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                                .tint(Color(red: 0.6, green: 0.61, blue: 0.63))
                            Text(waltmate.city)
                                .font(.pretendardBody10)
                                .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                        }
                        
                        Text(startDateString)
                            .font(.pretendardBody10)
                            .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 10) {
                            AppResourceAsset.Image.icWalkmatePerson.swiftUIImage
                                .foregroundStyle(AppResourceAsset.Color.dubbyYellow.swiftUIColor)
                                .tint(AppResourceAsset.Color.dubbyYellow.swiftUIColor)
                            
                            Text("\(waltmate.applyCount) / \(waltmate.totalCount)명")
                                .font(.pretendardTitle10)
                                .foregroundStyle(AppResourceAsset.Color.lubbyBlue.swiftUIColor)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
            }
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 0.83)
                .foregroundStyle(Color(red: 0.91, green: 0.91, blue: 0.91))
        }
    }
}
