//
//  ProfileView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/19/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem
import UIComponent

import ComposableArchitecture
import Kingfisher

public struct ProfileView: View {
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    let store: StoreOf<Profile>
    
    public init(store: StoreOf<Profile>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            ZStack {
                if store.isLoading {
                    LoadingView()
                        .zIndex(10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    ScrollView {
                        ZStack {
                            Button(action: { store.send(.view(.logoutButtonTapped))}) {
                                AppResourceAsset.Image.icSetting.swiftUIImage
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 33, height: 33, alignment: .trailing)
                            .position(x: UIScreen.main.bounds.width - 33, y: 0)
                            
                            VStack(spacing: .zero) {
                                if let profileImageURL = store.profile?.imageURL {
                                    KFImage(profileImageURL)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .padding(.horizontal, 125)
                                        .clipShape(.circle)
                                        .overlay {
                                            Circle()
                                                .strokeBorder(.white, lineWidth: 3)
                                        }
                                    
                                }
                                
                                if let name = store.profile?.name {
                                    Text(name)
                                        .font(.npsTitle16)
                                        .padding(.top, 6)
                                }
                                
                                if let description = store.profile?.description {
                                    Text(description)
                                        .font(.pretendardBody10)
                                        .foregroundStyle(Color(red: 0.61, green: 0.6, blue: 0.6))
                                        .padding(.top, 3)
                                }
                                
                                let rows = [
                                    GridItem(.flexible(), spacing: .zero),
                                    GridItem(.flexible(), spacing: .zero),
                                    GridItem(.flexible(), spacing: .zero)
                                ]
                                
                                let descriptions: [ProfileDescriptionView.Model] = [
                                    .init(title: "게시글", value: "\(store.profile?.postCount ?? .zero)"),
                                    .init(title: "Cuddle과 함께한지", value: "\(store.profile?.joinDay ?? .zero)일째"),
                                    .init(title: "반려동물 수", value: "\(store.profile?.cuddlersCount ?? .zero)")
                                ]
                                
                                VStack {
                                    Rectangle()
                                        .frame(height: 0.75)
                                        .foregroundStyle(Color(red: 0.92, green: 0.92, blue: 0.92))
                                    
                                    LazyVGrid(columns: rows, spacing: .zero) {
                                        ForEach(descriptions, id: \.title) { model in
                                            HStack(spacing: 8) {
                                                if model.title == "Cuddle과 함께한지" {
                                                    Divider()
                                                        .padding(.vertical, 4)
                                                }
                                                ProfileDescriptionView(model: model)
                                                    .frame(maxWidth: .infinity)
                                                
                                                if model.title == "Cuddle과 함께한지" {
                                                    Divider()
                                                        .padding(.vertical, 4)
                                                }
                                            }
                                            .frame(maxWidth: .infinity)
                                        }
                                    }
                                    
                                    Rectangle()
                                        .frame(height: 0.75)
                                        .foregroundStyle(Color(red: 0.92, green: 0.92, blue: 0.92))
                                    
                                }
                                .padding(.horizontal, 30)
                                .padding(.top, 14)
                                
                                CuddleTextButton(
                                    action: {
                                        store.send(.view(.userProfileButtonTapped(store.profile)))
                                    },
                                    theme: .primary(.custom(AppResourceAsset.Color.cuddleGreen.swiftUIColor)),
                                    text: "프로필 수정",
                                    font: .pretendardTitle12,
                                    isEnabled: .constant(true)
                                )
                                .padding(.horizontal, 28)
                                .padding(.top, 16)
                                
                                
                                let columns: [GridItem] = [
                                    GridItem(.flexible(), spacing: 12), // 첫 번째 열
                                    GridItem(.flexible())  // 두 번째 열
                                ]
                                
                                LazyVGrid(columns: columns, spacing: 12) {
                                    ForEach(store.cuddlerItems, id: \.value) { type in
                                        switch type {
                                        case let .profile(profile):
                                            CuddlerProfileView(
                                                cuddler: profile,
                                                editAction: { store.send(.view(.editButtonTapped($0)), animation: .easeInOut)  }
                                            )
                                        case .add:
                                            CuddlerAddProfileView(
                                                action: { store.send(.view(.registerButtonTapped)) }
                                            )
                                        }
                                    }
                                }
                                .padding(.top, 24)
                                .padding(.horizontal, 18)
                            }
                        }
                        .padding(.vertical, 32)
                    }
                }
            }
            .onAppear { store.send(.view(.onAppear)) }
            .navigationBarTitle("", displayMode: .inline) //this must be empty
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }

}

public struct ProfileDescriptionView: View {
    
    public struct Model {
        public let title: String
        public let value: String
        
        public init(title: String, value: String) {
            self.title = title
            self.value = value
        }
    }
    
    public init(model: Model) {
        self.model = model
    }
    
    let model: Model
    
    public var body: some View {
        VStack(spacing: 6) {
            Text(model.title)
                .font(.pretendardBody10)
                .foregroundStyle(Color(red: 0.6, green: 0.61, blue: 0.63))
            
            Text(model.value)
                .font(.pretendardTitle10)
        }
        .padding(.horizontal, 6)
    }
}
