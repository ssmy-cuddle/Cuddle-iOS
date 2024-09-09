//
//  DailyPreviewItemView.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/5/24.
//

import Foundation
import SwiftUI

import Kingfisher

public struct DailyPreviewItemView: View {
    
    private let daily: DailyPreviewModel
    
    public init(daily: DailyPreviewModel) {
        self.daily = daily
    }
    
    public var body: some View {
        VStack {
            KFImage(daily.thumbnailURL)
                .resizable()
                .aspectRatio(140 / 129, contentMode: .fill)
                .clipped()
                .clipShape(.rect(cornerRadius: 6))
            
            Text(daily.title)
                .font(.pretendardBody12)
            
            HStack(spacing: 6) {
                KFImage(daily.profileImage)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .clipShape(.circle)
        
                Text(daily.nickname)
                    .font(.pretendardBody10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
