//
//  TravelPreviewContentView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/19/24.
//

import Foundation
import SwiftUI

import DesignSystem

import Kingfisher

public struct TravelPreviewContentView: View {
    
    let travelPreview: TravelPreviewModel
    
    public var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                KFImage(travelPreview.profileImage)
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .clipShape(.circle)
                    .frame(width: 22, height: 22)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .circular)
                            .strokeBorder(.white, lineWidth: 2)
                    }
                Text(travelPreview.nickname)
                    .font(.pretendardBody12)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 12)
            
            VStack(spacing: 0) {
                HStack(spacing: .zero) {
                    ForEach(travelPreview.thumbnailURLList, id: \.absoluteString) {
                        KFImage($0)
                            .resizable()
                            .aspectRatio(150 / 167, contentMode: .fill)
                            .frame(alignment: .center)
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text(travelPreview.title)
                        .font(.pretendardBody14)
                    Text(travelPreview.description)
                        .font(.pretendardBody12)
                        .foregroundStyle(Color(red: 0.52, green: 0.52, blue: 0.52))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .clipped()
            }
            .clipShape(.rect(cornerRadius: 6))
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .strokeBorder(.black.opacity(0.1), lineWidth: 1)
            }
        }
    }
}
