//
//  HomeView.swift
//  HomeFeature
//
//  Created by mvldev7 on 7/17/24.
//

import Foundation
import SwiftUI

public struct HomeView: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            OriginalView(contents: MockOriginalContent.contents)
            
            BannerView(banners: MockBanner.banners)
                .aspectRatio(290 / 71, contentMode: .fit)
                .padding(.horizontal, 16)
                .padding(.top, 20)
            
        }
    }
    
}

public struct HomeHeaderView: View {
    
    public var body: some View {
        Text("This is Header")
            .frame(width: .infinity, height: 300)
            .background(.blue)
            .ignoresSafeArea(.all, edges: .top)
    }
}
