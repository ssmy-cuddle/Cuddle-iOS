//
//  RegisterView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import PhotosUI
import SwiftUI

import AppResource
import DesignSystem
import UIComponent

import ComposableArchitecture

public struct RegisterView: View {
    
    private enum ElementID {
        case confirmButton
    }
    
    @Bindable private var store: StoreOf<RegisterFeature>
    @ObservedObject private var keyboardResponder = KeyboardResponder()
//    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject private var tabBarVisibility: TabBarVisibility
    
    public init(store: StoreOf<RegisterFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                if store.isLoading {
                    LoadingView()
                        .zIndex(10)
                }
                VStack {
                    CuddleNavigationBar(title: "글 등록") {
                        store.send(.view(.backButtomTapped))
                    }
                    GeometryReader { geometry in
                        ScrollViewReader { proxy in
                            ScrollView {
                                ZStack {
                                    Color.white // 전체 배경을 설정하여 제스처 감지
                                        .allowsHitTesting(keyboardResponder.isKeyboardVisible)
                                        .onTapGesture {
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        }
                                    VStack(spacing: 15) {
                                        photoListView()
                                        descriptionTextEditor()
                                            .onTapGesture { proxy.scrollTo(ElementID.confirmButton, anchor: .top) }
                                        Spacer()
                                        confirmButton()
                                            .id(ElementID.confirmButton)
                                    }
                                    .padding(.horizontal, 20)
                                    .onChange(of: keyboardResponder.isKeyboardVisible) { _, isKeyboardVisible in
                                        if isKeyboardVisible {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                                withAnimation {
                                                    proxy.scrollTo(ElementID.confirmButton, anchor: .bottom)
                                                }
                                            }
                                        }
                                    }
                                }
                                .frame(minHeight: geometry.size.height)
                            }
                        }
                        .frame(minHeight: geometry.size.height)
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline) //this must be empty
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
//        .onAppear {
//            tabBarVisibility.isTabBarVisible = false
//        }
    }
}

extension RegisterView {
    
    @ViewBuilder
    private func photoListView() -> some View {
        VStack(alignment: .leading) {
            Text("내용")
                .font(.pretendardTitle12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    if store.selectedImages.count <= 4 {
                        photoPickerView()
                    }
                    ForEach(store.selectedImages, id: \.self) { image in
                        photoView(
                            image: image,
                            onRemoveButtonTap: {
                                print("Button Tapped")
                                store.send(.view(.imageRemoveButtonTapped($0)))
                            }
                        )
                    }
                }
            }
            .frame(maxWidth: ((65.0 + 16.0) * CGFloat(store.selectedImages.count + 1)) + 65)
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    private func photoPickerView() -> some View {
        CuddlePhotoPicker(
            selectedPhotos: [],
            selectedImages: $store.selectedImages
        ) {
            Rectangle()
                .frame(width: 65, height: 65, alignment: .leading)
                .foregroundColor(Color(red: 0.91, green: 0.91, blue: 0.91))
                .clipShape(.rect(cornerRadius: 6))
                .overlay {
                    VStack(spacing: .zero) {
                        AppResourceAsset.Image.icCameraAddition.swiftUIImage
                            .foregroundStyle(.black)
                        Text("\(store.selectedImages.count)/5")
                            .font(.npsTitle10)
                            .foregroundStyle(.black)
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
    
    private func photoView(
        image: UIImage,
        onRemoveButtonTap: @escaping (UIImage) -> Void
    ) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 65, height: 65, alignment: .bottomLeading)
                .clipShape(.rect(cornerRadius: 6))
            
            Button(action: { onRemoveButtonTap(image) }) {
                AppResourceAsset.Image.icRemoveImage.swiftUIImage
                    .resizable()
                    .frame(width: 16, height: 16)
                    .clipShape(.circle)
            }
            .offset(x: 8, y: -8)
        }
    }
    
    @ViewBuilder
    private func descriptionTextEditor() -> some View {
        ZStack(alignment: .topLeading) {
            if store.descriotion.isEmpty {
                Text("세부 내용을 작성해주세요.")
                    .font(.pretendardBody12)
                    .frame(alignment: .leading)
                    .foregroundStyle(Color(red: 0.74, green: 0.74, blue: 0.74))
                    .padding(.horizontal, 12)
                    .padding(.top, 16)
                    .zIndex(5)
                    .allowsHitTesting(false)
            }
            TextEditor(
                text: $store.descriotion
            )
            .frame(height: 160)
            .font(.pretendardBody12)
            .keyboardType(.default)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(.all, 8)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 0.75)
            }
        }
    }
    
    @ViewBuilder
    private func confirmButton() -> some View {
        CuddleTextButton(
            action: {
                tabBarVisibility.isTabBarVisible = false
                store.send(.view(.confrimButtonTapped))
            },
            theme: .primary(.yellow),
            text: "작성 완료",
            font: .pretendardTitle16,
            isEnabled: .constant(store.isConfirmButtonEnabled)
        )
        .padding(.top, 16)
        .padding(.bottom, 20)
    }
}


//        WithViewStore(store, observe: { $0 }) { store in
//            ZStack(alignment: .center) {
//                if store.isLoading {
//                    LoadingView()
//                }
//                
//                VStack {
//                    ZStack(alignment: .leading) {
//                        Rectangle()
//                            .foregroundColor(.white)
//                            .frame(height: 17 + 16 + 16)
//                            .frame(maxWidth: .infinity)
//                            .shadow(color: .black.opacity(0.1), radius: 3, x: .zero, y: 3)
//                        
//                        Text("글 등록")
//                            .padding(.all, 16)
//                            .font(.pretendardTitle14)
//                            .frame(maxWidth: .infinity)
//                            .multilineTextAlignment(.center)
//                        
//                        Button(
//                            action: { store.send(.back) }
//                        ) {
//                            AppResourceAsset.Image.icButtonBack.swiftUIImage
//                                .foregroundColor(.black)
//                                .frame(width: 36, height: 36, alignment: .leading)
//                        }
//                    }
//                    
//                    GeometryReader { geometry in
//                        ScrollView {
//                            VStack(spacing: 15) {
////                                VStack(spacing: 9) {
////                                    Text("제목")
////                                        .font(.pretendardTitle12)
////                                        .frame(maxWidth: .infinity, alignment: .leading)
////                                    
////                                    TextField(
////                                        "제목",
////                                        text: $store.title
////                                    )
////                                    .font(.pretendardBody12)
////                                    .keyboardType(.default)
////                                    .textInputAutocapitalization(.never)
////                                    .autocorrectionDisabled()
////                                    .padding(.all, 12)
////                                    .overlay {
////                                        RoundedRectangle(cornerRadius: 4)
////                                            .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 0.75)
////                                    }
////                                }
////                                .padding(.horizontal, 20)
//                                
//                                VStack {
//                                    Text("내용")
//                                        .font(.pretendardTitle12)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                    
//                                    ScrollView(.horizontal) {
//                                        
//                                        HStack(spacing: 4) {
//                                            if store.selectedImages.count <= 4 {
//                                                CuddlePhotoPicker(
//                                                    selectedPhotos: [],
//                                                    selectedImages: store.binding(
//                                                        get: \.selectedImages,
//                                                        send: { .binding(.set(\.selectedImages, $0))}
//                                                    )
//                                                ) {
//                                                    Rectangle()
//                                                        .frame(width: 65, height: 65, alignment: .leading)
//                                                        .foregroundColor(Color(red: 0.91, green: 0.91, blue: 0.91))
//                                                        .clipShape(.rect(cornerRadius: 6))
//                                                        .overlay {
//                                                            VStack(spacing: .zero) {
//                                                                AppResourceAsset.Image.icCameraAddition.swiftUIImage
//                                                                    .foregroundStyle(.black)
//                                                                Text("\(store.selectedImages.count)/5")
//                                                                    .font(.npsTitle10)
//                                                                    .foregroundStyle(.black)
//                                                            }
//                                                        }
//                                                }
//                                                .frame(maxWidth: .infinity, alignment: .leading)
//                                                .padding(.vertical, 8)
//                                            }
//                                            
//                                            ForEach(store.selectedImages, id: \.hashValue) { image in
//                                                ZStack(alignment: .topTrailing) {
//                                                    // 배경 이미지
//                                                    Image(uiImage: image)
//                                                        .resizable()
//                                                        .frame(width: 65, height: 65)
//                                                        .clipShape(.rect(cornerRadius: 6))
//                                                    
//                                                    // X 버튼
//                                                    Button(action: {
//                                                        store.send(.removeImage(image))
//                                                    }) {
//                                                        AppResourceAsset.Image.icRemoveImage.swiftUIImage
//                                                            .frame(width: 16, height: 16)
//                                                            .clipShape(.circle)
//                                                    }
//                                                    .offset(x: 8, y: -8)
//                                                }
//                                                .padding(8)
//                                                
//                                                
//                                            }
//                                        }
//                                    }
//                                    .scrollIndicators(.hidden)
//                                    
//                                    ZStack(alignment: .topLeading) {
//                                        if store.descriotion.isEmpty {
//                                            Text("세부 내용을 작성해주세요.")
//                                                .font(.pretendardBody12)
//                                                .frame(alignment: .leading)
//                                                .foregroundStyle(Color(red: 0.74, green: 0.74, blue: 0.74))
//                                                .padding(.horizontal, 12)
//                                                .padding(.top, 16)
//                                                .zIndex(5)
//                                        }
//                                        TextEditor(
//                                            text: store.binding(
//                                                get: \.descriotion,
//                                                send: { .binding(.set(\.descriotion, $0))}
//                                            )
//                                        )
//                                        .frame(height: 160)
//                                        .font(.pretendardBody12)
//                                        .keyboardType(.default)
//                                        .textInputAutocapitalization(.never)
//                                        .autocorrectionDisabled()
//                                        .padding(.all, 8)
//                                        .overlay {
//                                            RoundedRectangle(cornerRadius: 4)
//                                                .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 0.75)
//                                        }
//                                    }
//                                }
//                                .padding(.horizontal, 20)
//                                
//                                Spacer()
//                                
//                                CuddleTextButton(
//                                    action: { store.send(.confirm) },
//                                    theme: .primary(.yellow),
//                                    text: "작성 완료",
//                                    font: .pretendardTitle16,
//                                    isEnabled: .constant(true)
//                                )
//                                .padding(.horizontal, 20)
//                                .padding(.vertical, 16)
//                            }
//                            .padding(.top, 24)
//                            .frame(minHeight: geometry.size.height)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: geometry.size.height)
//                        
//                    }
//                }
//            }
//            .navigationBarTitle("", displayMode: .inline) //this must be empty
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//        }
//    }
//}
//
public struct CuddlerTextField: View {
    
    @State var title: String
    @State var placeHolder: String
    @State var isRequired: Bool
    @Binding var value: String
    
    public init(title: String, placeHolder: String, isRequired: Bool, value: Binding<String>) {
        self.title = title
        self.placeHolder = placeHolder
        self.isRequired = isRequired
        self._value = value
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.npsTitle12)
                if isRequired {
                    Text("*")
                        .font(.npsTitle12)
                        .foregroundStyle(AppResourceAsset.Color.lubbyBlue.swiftUIColor)
                }
            }
            
            TextField(placeHolder, text: $value)
                .font(.pretendardBody12)
                .keyboardType(.default)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding(.all, 12)
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 0.75)
                }
        }
    }
}
