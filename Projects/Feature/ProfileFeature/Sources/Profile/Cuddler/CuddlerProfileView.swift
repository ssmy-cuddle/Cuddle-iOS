//
//  CuddlerProfileView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/20/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem
import ProfileFeatureInterface

import Kingfisher

public enum CuddlerProfileViewType {
    case profile
    case information
    
    public func toggle() -> Self {
        switch self {
        case .profile: .information
        case .information: .profile
        }
    }
    
    var isProfileVisible: Bool {
        switch self {
        case .profile: true
        case .information: false
        }
    }
    
    var isInformationVisible: Bool {
        switch self {
        case .profile: false
        case .information: true
        }
    }
}

public struct CuddlerProfileView: View {
    
    let cuddler: CuddlerProfileModel
    let editAction: (CuddlerProfileModel) -> Void
    
    @State public var viewType: CuddlerProfileViewType = .profile
    @State private var rotationAngle: Double = 0
       
    public var body: some View {
        ZStack {
            switch viewType {
            case .profile:
                profileView()
                    .opacity(viewType.isProfileVisible ? 1 : 0)
            case .information:
                informationView()
                    .opacity(viewType.isInformationVisible ? 1 : 0)
            }

        }
        .aspectRatio(135 / 187, contentMode: .fit)
        .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
        .animation(.easeInOut(duration: 0.6), value: rotationAngle)
        .onTapGesture { onTapGesture() }
    }
    
    private func onTapGesture() {
        rotationAngle += 180
        viewType = viewType.toggle()
    }
}

extension CuddlerProfileView {
    
    // MARK: - Profile
    
    @ViewBuilder
    private func profileView() -> some View {
        ZStack(alignment: .topTrailing) {
            profileBackgroundView()
            profileEditButton { editAction(cuddler) }
            VStack(spacing: .zero) {
                profileNameText()
                profileImageView()
                withDateText()
            }
        }
    }
    
    @ViewBuilder 
    private func profileBackgroundView() -> some View {
        AppResourceAsset.Image.icProfileCuddlerBackground.swiftUIImage
            .resizable()
            .aspectRatio(135 / 187, contentMode: .fit)
            .shadow(
                color: .black.opacity(0.15),
                radius: 5,
                x: .zero,
                y: 7
            )
    }
    
    @ViewBuilder
    private func profileEditButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            AppResourceAsset.Image.icProfileEdit.swiftUIImage
                .foregroundStyle(.black)
        }
        .frame(width: 24, height: 24)
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
    }
    
    @ViewBuilder
    private func profileNameText() -> some View {
        Text(cuddler.name)
            .font(.npsTitle14)
            .padding(.top, 26)
            .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private func profileImageView() -> some View {
        KFImage(cuddler.imageURL)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding(.horizontal, 30)
            .clipShape(.circle)
    }
    
    @ViewBuilder
    private func withDateText() -> some View {
        (Text("함께한지 ") +
         Text("\(cuddler.withDay)").foregroundStyle(AppResourceAsset.Color.lubbyBlue.swiftUIColor) +
         Text(" 일째")
        )
        .font(.npsTitle12)
        .padding(.top, 18)
        .padding(.bottom, 22)
    }
    
    // MARK: - Information
    
    @ViewBuilder
    private func informationView() -> some View {
        ZStack(alignment: .topTrailing) {
            GeometryReader { proxy in
               informationBackgroundView(proxy: proxy)
            }
        }
        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
    }
    
    @ViewBuilder
    private func informationBackgroundView(proxy: GeometryProxy) -> some View {
        Rectangle()
            .foregroundStyle(.white)
            .aspectRatio(135 / 187, contentMode: .fit)
            .clipShape(.rect(cornerRadius: proxy.size.width / 6))
            .shadow(
                color: .black.opacity(0.15),
                radius: 4,
                x: .zero,
                y: 4
            )
            .overlay { informationOverlayView() }
    }
    
    @ViewBuilder
    private func informationOverlayView() -> some View {
        VStack(spacing: 12) {
            genderView(gender: cuddler.gender.title)
            kindView(kind: cuddler.kind)
            birthView(birth: cuddler.birth)
            weightView(weight: cuddler.weight)
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func genderView(gender: String) -> some View {
        HStack {
            Text("성별")
                .font(.npsTitle12)
            Spacer()
            Text(gender)
                .font(.npsTitle12)
        }
    }
    
    @ViewBuilder
    private func kindView(kind: String) -> some View {
        HStack {
            Text("품종")
                .font(.npsTitle12)
            Spacer()
            Text(kind)
                .font(.npsTitle12)
        }
    }
    
    @ViewBuilder
    private func weightView(weight: Double) -> some View {
        HStack {
            Text("무게")
                .font(.npsTitle12)
            Spacer()
            Text("\(String(weight))kg")
                .font(.npsTitle12)
        }
    }
    
    @ViewBuilder
    private func birthView(birth: Date) -> some View {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return HStack {
            Text("생일")
                .font(.npsTitle12)
            Spacer()
            Text("\(dateFormatter.string(from: birth))")
                .font(.npsTitle12)
        }
    }
}
