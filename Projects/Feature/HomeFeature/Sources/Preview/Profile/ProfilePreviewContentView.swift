//
//  ProfilePreviewContentView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/29/24.
//

import Foundation
import SwiftUI

import DesignSystem

import Kingfisher

public struct ProfilePreviewContentView: View {
    
    let profile: ProfilePreviewModel
    
    public init(
        profile: ProfilePreviewModel
    ) {
        self.profile = profile
    }
    
    public var body: some View {
        VStack(spacing: 5) {
            KFImage(profile.profileImageURL)
                .resizable()
                .aspectRatio(140 / 129, contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 0.43)
                .clipShape(.rect(cornerRadius: 6))
            
            HStack(spacing: 6) {
                KFImage(profile.userProfileImageURL)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .aspectRatio(1, contentMode: .fill)
                    .clipShape(.circle)
                    .overlay {
                        RoundedRectangle(cornerRadius: 14, style: .circular)
                            .strokeBorder(.white, lineWidth: 2)
                    }
                Text(profile.nickname)
                    .font(.pretendardBody12)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
