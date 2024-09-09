//
//  HomeView+Skeleton.swift
//  HomeFeature
//
//  Created by mvldev7 on 9/5/24.
//

import Foundation
import SwiftUI

import SkeletonUI

public struct HomeSkeletonView: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            GeometryReader { proxy in
                VStack(alignment: .leading) {
                    headerView
                        .padding(.horizontal, 8)
                        .padding(.bottom, 80)
                    
                    originalHeaderView
//                        .padding(.horizontal, 16)
                    
                    originalView(proxy: proxy)
                    
                    bannerView
                    
                    VStack {
                        dailyHeaderView
                        dailyView
                    }
                    .padding(.top, 28)
                }
                .padding(.horizontal, 16)
                .blinking(duration: 0.75)
            }
        }
    }
}

extension HomeSkeletonView {
    
    @ViewBuilder private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                SkeletonCellView()
                    .frame(width: 63, height: 20)
                SkeletonCellView()
                    .frame(width: 90, height: 22)
            }
            Spacer()
            SkeletonCellView()
                .frame(width: 47, height: 45)
        }
    }
    
    @ViewBuilder private var originalHeaderView: some View {
        HStack {
            SkeletonCellView()
                .frame(width: 135, height: 22)
            Spacer()
            SkeletonCellView()
                .frame(width: 33, height: 22)
        }
    }
    
    @ViewBuilder private func originalView(proxy: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                ForEach(0...2, id: \.self) { _ in
                    originalContentView(proxy: proxy)
                }
            }
        }
    }

    @ViewBuilder private func originalContentView(
        proxy: GeometryProxy
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            SkeletonCellView()
                .aspectRatio(226 / 156, contentMode: .fill)
                .frame(width: proxy.size.width * 0.8)
                .clipShape(.rect(cornerRadius: 8))
            
            SkeletonCellView()
                .frame(width: 116, height: 17)
            
            SkeletonCellView()
                .frame(width: 116, height: 17)
        }
    }
    
    @ViewBuilder private var bannerView: some View {
        SkeletonCellView()
            .aspectRatio(290 / 71, contentMode: .fill)
            .clipShape(.rect(cornerRadius: 8))
            .padding(.top, 20)
    }
    
    @ViewBuilder private var dailyHeaderView: some View {
        HStack {
            SkeletonCellView()
                .frame(width: 116, height: 25)
            Spacer()
            SkeletonCellView()
                .frame(width: 33, height: 22)
        }
        .padding(.top, 28)
    }
    
    @ViewBuilder private var dailyContentView: some View {
        VStack(spacing: 10) {
            SkeletonCellView()
                .aspectRatio(140 / 129, contentMode: .fill)
                .clipShape(.rect(cornerRadius: 6))
            
            SkeletonCellView()
                .frame(height: 10)
                .frame(maxWidth: .infinity)
            
            SkeletonCellView()
                .frame(height: 10)
                .frame(maxWidth: .infinity)
            
            HStack {
                SkeletonCellView()
                    .frame(width: 20, height: 20)
                
                SkeletonCellView()
                    .frame(width: 26, height: 20)
                
                Spacer()
                
                SkeletonCellView()
                    .frame(width: 22, height: 20)
            }
        }
    }
    
    @ViewBuilder private var dailyView: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0...4, id: \.self) { _ in
                dailyContentView
            }
        }
    }
}
