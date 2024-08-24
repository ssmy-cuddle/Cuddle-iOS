//
//  RegisterView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/21/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

import ComposableArchitecture

import PhotosUI

public struct RegisterView: View {
    
    @Bindable var store: StoreOf<Register>
    
    @State private var selectedImageData: [Data] = []
    
    //    @State private var selectedPhotos: [PhotosPickerItem] = []
    //    @State var selectedImages: [UIImage] = []
    //    @Binding var selectedImages: [UIImage]
    
    public init(store: StoreOf<Register>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { store in
            ZStack(alignment: .center) {
                if store.isLoading {
                    ProgressView()
                        .zIndex(40)
                }
                
                VStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 17 + 16 + 16)
                            .frame(maxWidth: .infinity)
                            .shadow(color: .black.opacity(0.1), radius: 3, x: .zero, y: 3)
                        
                        Text("글 등록")
                            .padding(.all, 16)
                            .font(.pretendardTitle14)
                            .frame(maxWidth: .infinity)
                            .multilineTextAlignment(.center)
                        
                        Button(
                            action: { store.send(.back) }
                        ) {
                            AppResourceAsset.Image.icButtonBack.swiftUIImage
                                .foregroundColor(.black)
                                .frame(width: 36, height: 36, alignment: .leading)
                        }
                    }
                    
                    GeometryReader { geometry in
                        ScrollView {
                            VStack(spacing: 15) {
//                                VStack(spacing: 9) {
//                                    Text("제목")
//                                        .font(.pretendardTitle12)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                    
//                                    TextField(
//                                        "제목",
//                                        text: $store.title
//                                    )
//                                    .font(.pretendardBody12)
//                                    .keyboardType(.default)
//                                    .textInputAutocapitalization(.never)
//                                    .autocorrectionDisabled()
//                                    .padding(.all, 12)
//                                    .overlay {
//                                        RoundedRectangle(cornerRadius: 4)
//                                            .stroke(Color(red: 0.91, green: 0.91, blue: 0.91), lineWidth: 0.75)
//                                    }
//                                }
//                                .padding(.horizontal, 20)
                                
                                VStack {
                                    Text("내용")
                                        .font(.pretendardTitle12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    ScrollView(.horizontal) {
                                        
                                        HStack(spacing: 4) {
                                            if store.selectedImages.count <= 4 {
                                                GreenPhotoPicker(
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
                                            
                                            ForEach(store.selectedImages, id: \.hashValue) { image in
                                                ZStack(alignment: .topTrailing) {
                                                    // 배경 이미지
                                                    Image(uiImage: image)
                                                        .resizable()
                                                        .frame(width: 65, height: 65)
                                                        .clipShape(.rect(cornerRadius: 6))
                                                    
                                                    // X 버튼
                                                    Button(action: {
                                                        store.send(.removeImage(image))
                                                    }) {
                                                        AppResourceAsset.Image.icRemoveImage.swiftUIImage
                                                            .frame(width: 16, height: 16)
                                                            .clipShape(.circle)
                                                    }
                                                    .offset(x: 8, y: -8)
                                                }
                                                .padding(8)
                                                
                                                
                                            }
                                        }
                                    }
                                    .scrollIndicators(.hidden)
                                    
                                    ZStack(alignment: .topLeading) {
                                        if store.descriotion.isEmpty {
                                            Text("세부 내용을 작성해주세요.")
                                                .font(.pretendardBody12)
                                                .frame(alignment: .leading)
                                                .foregroundStyle(Color(red: 0.74, green: 0.74, blue: 0.74))
                                                .padding(.horizontal, 12)
                                                .padding(.top, 16)
                                                .zIndex(5)
                                        }
                                        TextEditor(
                                            text: store.binding(
                                                get: \.descriotion,
                                                send: { Register.Action.binding(.set(\.descriotion, $0))}
                                            )
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
                                .padding(.horizontal, 20)
                                
                                Spacer()
                                
                                CuddleTextButton(
                                    action: { store.send(.confirm) },
                                    theme: .primary(.yellow),
                                    text: "작성 완료",
                                    font: .pretendardTitle16
                                )
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                            }
                            .padding(.top, 24)
                            .frame(minHeight: geometry.size.height)
                        }
                        .frame(maxWidth: .infinity, minHeight: geometry.size.height)
                        
                    }
                }
            }
        }
    }
}

public struct CuddleTextField: View {
    
    @State private var text: String = ""
    
    public var body: some View {
        VStack(spacing: 9) {
            Text("제목")
                .font(.pretendardTitle12)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("제목", text: $text)
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

public struct GreenPhotoPicker<Content: View>: View {
    
    @State private var selectedPhotos: [PhotosPickerItem]
    @Binding private var selectedImages: [UIImage]
    @Binding private var isPresentedError: Bool
    private let maxSelectedCount: Int
    private var disabled: Bool {
        selectedImages.count >= maxSelectedCount
    }
    private var availableSelectedCount: Int {
        maxSelectedCount - selectedImages.count
    }
    private let matching: PHPickerFilter
    private let photoLibrary: PHPhotoLibrary
    private let content: () -> Content
    
    public init(
        selectedPhotos: [PhotosPickerItem] = [],
        selectedImages: Binding<[UIImage]>,
        isPresentedError: Binding<Bool> = .constant(false),
        maxSelectedCount: Int = 5,
        matching: PHPickerFilter = .images,
        photoLibrary: PHPhotoLibrary = .shared(),
        content: @escaping () -> Content
    ) {
        self.selectedPhotos = selectedPhotos
        self._selectedImages = selectedImages
        self._isPresentedError = isPresentedError
        self.maxSelectedCount = maxSelectedCount
        self.matching = matching
        self.photoLibrary = photoLibrary
        self.content = content
    }
    
    public var body: some View {
        PhotosPicker(
            selection: $selectedPhotos,
            maxSelectionCount: availableSelectedCount,
            matching: matching,
            photoLibrary: photoLibrary
        ) {
            content()
                .disabled(disabled)
        }
        .disabled(disabled)
        .onChange(of: selectedPhotos) { _, newValue in
            handleSelectedPhotos(newValue)
        }
    }
    
    private func handleSelectedPhotos(_ newPhotos: [PhotosPickerItem]) {
        for newPhoto in newPhotos {
            newPhoto.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data, let newImage = UIImage(data: data) {
                        if !selectedImages.contains(where: { $0.pngData() == newImage.pngData() }) {
                            DispatchQueue.main.async {
                                selectedImages.append(newImage)
                            }
                        }
                    }
                case .failure:
                    isPresentedError = true
                }
            }
        }
        selectedPhotos.removeAll()
    }
}
