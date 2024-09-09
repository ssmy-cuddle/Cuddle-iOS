//
//  UserProfileInputView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 9/7/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem
import UIComponent

import ComposableArchitecture
import Kingfisher

public struct UserProfileInputView: View {
    
    let store: StoreOf<UserProfileInputFeature>
    
    public init(store: StoreOf<UserProfileInputFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            VStack {
                CuddleNavigationBar() { store.send(.view(.back)) }
                GeometryReader { proxy in
                    ScrollView {
                        VStack {
                            Text("프로필 수정")
                                .font(.custom(Pretendard.title.name, size: 22))
                                .padding(.top, 22)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            CuddlePhotoPicker(
                                selectedPhotos: [],
                                selectedImages: store.binding(
                                    get: \.image.images,
                                    send: { .binding(.set(\.image, .preRegistration($0.first!))) }
                                ),
                                maxSelectedCount: 1
                            ) {
                                profileImageView(store: store)
                            }
                                .padding(.horizontal, 102)
                                .padding(.top, 16)
                            
                            VStack(spacing: 20) {
                                nickNameTextField(
                                    binding: store.binding(
                                        get: \.name,
                                        send: { .binding(.set(\.name, $0)) }
                                    )
                                )
                                
                                descriptionTextField(
                                    binding: store.binding(
                                        get: \.description,
                                        send: { .binding(.set(\.description, $0)) }
                                    )
                                )
                            }
                            .padding(.vertical, 24)
                            
                            Spacer()
                            
                            CuddleTextButton(
                                action: {},
                                theme: .primary(.yellow),
                                text: "수정완료",
                                font: .pretendardTitle16
                            )
                            .padding(.bottom, 16)
                        }
                        .frame(minHeight: proxy.size.height)
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

extension UserProfileInputView {
    
    @ViewBuilder private func profileImageView(
        store: ViewStore<UserProfileInputFeature.State, UserProfileInputFeature.Action>
    ) -> some View {
        switch store.image {
        case let .url(imageURL):
            KFImage(imageURL)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .strokeBorder(.white, lineWidth: 3)
                }
        case let .preRegistration(image):
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .strokeBorder(.white, lineWidth: 3)
                }
        case .none:
            AppResourceAsset.Image.icCuddlerDefaultProfile.swiftUIImage
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .strokeBorder(.white, lineWidth: 3)
                }
        }
    }
    
    @ViewBuilder private func nickNameTextField(
        binding: Binding<String>
    ) -> some View {
        CuddlerTextField(
            title: "닉네임",
            placeHolder: "닉네임을 입력해주세요",
            isRequired: true,
            value: binding
        )
    }
    
    @ViewBuilder private func descriptionTextField(
        binding: Binding<String>
    ) -> some View {
        CuddlerTextField(
            title: "한줄소개",
            placeHolder: "한줄소개를 입력해주세요",
            isRequired: true,
            value: binding
        )
    }
}
