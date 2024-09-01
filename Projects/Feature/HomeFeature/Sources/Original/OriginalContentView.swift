//
//  OriginalContentView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/17/24.
//

import Foundation
import SwiftUI

import DesignSystem
import AppResource

import Kingfisher

public struct OriginalContentView: View {
    
    let content: OriginalContentModel
    
    public init(content: OriginalContentModel) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                KFImage(content.thumbnailImageURL)
                    .resizable()
                    .aspectRatio(226 / 156, contentMode: .fit)
                    .clipShape(.rect(cornerRadius: 8))
                
                Text(content.title)
                    .font(.npsTitle14)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                
                Text(content.description)
                    .font(.npsBody10)
                    .lineLimit(2)
            }
        }
    }
}
