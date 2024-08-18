//
//  HealthContentView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/14/24.
//

import Foundation
import SwiftUI

import DesignSystem

import Kingfisher

public struct HealthContentView: View {
    
    let healthContent: HealthContentModel
    
    public var body: some View {
        HStack(spacing: 16) {
            KFImage(healthContent.thumbnailURL)
                .resizable()
                .frame(width: 42, height: 42)
                .clipShape(.rect(cornerRadius: 6))
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(healthContent.title)
                        .font(.pretendardTitle12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 6)
                    
                    Text("3분전")
                        .font(.pretendardBody12)
                        .foregroundStyle(Color(red: 0.74, green: 0.74, blue: 0.74))
                }
                
                Text(healthContent.description)
                    .font(.pretendardBody10)
                    .frame(alignment: .leading)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.83)
                    .foregroundStyle(Color(red: 0.91, green: 0.91, blue: 0.91))
                    .contentMargins(.top, 12)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
