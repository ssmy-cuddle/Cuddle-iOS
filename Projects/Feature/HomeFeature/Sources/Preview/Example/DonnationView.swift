//
//  DonnationView.swift
//  HomeFeature
//
//  Created by mvldev7 on 8/30/24.
//

import Foundation
import SwiftUI

import AppResource

public struct DonnationView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    ZStack {
                        AppResourceAsset.Image.cuddleDonation.swiftUIImage
                            .resizable()
                            .aspectRatio(320 / 888, contentMode: .fit)
                    }
                }
                .ignoresSafeArea()
                .navigationBarTitle("", displayMode: .inline) //this must be empty
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .toolbar(.hidden, for: .tabBar)
                .toolbarBackground(.hidden, for: .tabBar)
            }
        }
//        
//        VStack {
//            ScrollView {
//                ZStack {
//                    AppResourceAsset.Image.cuddleDonation.swiftUIImage
//                        .resizable()
//                        .aspectRatio(320 / 888, contentMode: .fit)
//                }
//            }
//            .navigationBarTitle("", displayMode: .inline) //this must be empty
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//            .clipped()
//        }

//        .ignoresSafeArea()
//        .toolbar(.hidden, for: .tabBar)
//        .toolbarBackground(.hidden, for: .tabBar)
//        .toolbar(.hidden, for: .bottomBar)
//        .toolbarBackground(.hidden, for: .bottomBar)
    }
}
