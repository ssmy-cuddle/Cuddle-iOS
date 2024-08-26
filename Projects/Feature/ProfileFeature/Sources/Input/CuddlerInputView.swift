//
//  CuddlerInputView.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem
import UIComponent

import ComposableArchitecture
import Kingfisher

public struct CuddlerProfileInputView: View {
    
    @Bindable var store: StoreOf<CuddlerInput>
    
    public init(store: StoreOf<CuddlerInput>) {
        self.store = store
    }
    
    @ViewBuilder
    public var imageView: some View {
        switch store.image {
        case let .url(imageURL):
            KFImage(imageURL)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .stroke(.white, lineWidth: 3)
                }
            
        case let .preRegistration(image):
            Image(uiImage: image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .stroke(.white, lineWidth: 3)
                }
        case .none:
            AppResourceAsset.Image.icCuddlerDefaultProfile.swiftUIImage
                .resizable()
                .padding(22)
                .background(Color(red: 245/255, green: 245/255, blue: 245/255))
                .aspectRatio(1, contentMode: .fit)
                .clipShape(.circle)
                .overlay {
                    Circle()
                        .stroke(.white, lineWidth: 5)
                }
        }
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
                            .shadow(color: .black.opacity(0.1), radius: 3, x: .zero, y: 4)
                        
                        Button(
                            action: { store.send(.back) }
                        ) {
                            AppResourceAsset.Image.icButtonBack.swiftUIImage
                                .foregroundColor(.black)
                                .frame(width: 36, height: 36, alignment: .leading)
                        }
                    }
                    
                    ScrollView {
                        ZStack {
                            Color.white // 전체 배경을 설정하여 제스처 감지
                                .onTapGesture {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }
                            VStack(alignment: .leading) {
                                Text(store.title)
                                    .font(.custom(Pretendard.title.name, size: 22))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 22)
                                
                                CuddlePhotoPicker(
                                    selectedPhotos: [],
                                    selectedImages: store.binding(
                                        get: \.image.images,
                                        send: { .binding(.set(\.image, .preRegistration($0.first!))) }
                                    ),
                                    maxSelectedCount: 1
                                ) {
                                    imageView
                                }
                                .padding(.horizontal, 100)
                                .padding(.top, 22)
                                .shadow(
                                    color: Color(red: 0.4, green: 0.4, blue: 0.4).opacity(0.15),
                                    radius: 15,
                                    x: .zero,
                                    y: 3
                                )
                                
                                CuddlerTextField(
                                    title: "이름",
                                    placeHolder: "반려동물의 이름을 입력해주세요.",
                                    isRequired: true,
                                    value: $store.name
                                )
                                .padding(.horizontal, 20)
                                .padding(.top, 12)
                                
                                CuddleDatePickerView(
                                    title: "생일",
                                    isRequired: true,
                                    date: store.binding(
                                        get: { $0.birth },
                                        send: { .binding(.set(\.birth, $0 ?? Date())) }
                                    )
                                )
                                .padding(.horizontal, 20)
                                .padding(.top, 36)
                                
                                CuddlerTextField(
                                    title: "품종",
                                    placeHolder: "반려동물의 품종을 입력해주세요.",
                                    isRequired: true,
                                    value: $store.kind
                                )
                                .padding(.horizontal, 20)
                                .padding(.top, 36)
                                
                                CuddleDatePickerView(
                                    title: "입양 날짜",
                                    isRequired: true,
                                    date: store.binding(
                                        get: { $0.withDate },
                                        send: { .binding(.set(\.withDate, $0 ?? Date())) }
                                    )
                                )
                                .padding(.horizontal, 20)
                                .padding(.top, 36)
                                
                                CuddleDatePickerView(
                                    title: "이별 날짜",
                                    isRequired: false,
                                    date: store.binding(
                                        get: { $0.endDate },
                                        send: { .binding(.set(\.endDate, $0 ?? Date())) }
                                    )
                                )
                                .padding(.horizontal, 20)
                                .padding(.top, 36)
                                
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    Text("성별")
                                        .font(.npsTitle12)
                                    HStack {
                                        ForEach(GenderModel.allCases, id: \.hashValue) { gender in
                                            CuddleRadioContentView(
                                                value: gender.shortenTitle,
                                                selectedValue: store.gender?.shortenTitle,
                                                action: { store.send(.binding(.set(\.gender, gender)))}
                                            )
                                            .frame(maxWidth: .infinity)
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 30)
                                
                                VStack(alignment: .leading) {
                                    Text("몸무게")
                                        .font(.npsTitle12)
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            TextField(
                                                "",
                                                text: store.binding(
                                                    get: { String($0.weight) },
                                                    send: { .binding(.set(\.weight, Double($0) ?? .zero )) }
                                                )
                                            )
                                            .font(.npsTitle12)
                                            .keyboardType(.decimalPad)
                                            .frame(width: 60)
                                            
                                            Rectangle()
                                                .frame(height: 1)
                                        }
                                        Text("kg")
                                            .font(.npsTitle12)
                                        
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 36)
                                .frame(maxWidth: 120, alignment: .leading)
                                
                                CuddleTextButton(
                                    action: { store.send(.confirm) },
                                    theme: .primary(.yellow),
                                    text: "\(store.buttonTitle)",
                                    font: .pretendardTitle16
                                )
                                .padding(.horizontal, 20)
                                .padding(.vertical, 28)
                            }
                            .padding(.top, 10)
                        }
                    }
                }
            }
        }
    }
}

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

public struct CuddleDatePickerView: View {
    
    @State private var title: String
    @State private var isRequired: Bool
    @Binding private var date: Date?
    
    public init(title: String, isRequired: Bool, date: Binding<Date?>) {
        self.title = title
        self.isRequired = isRequired
        self._date = date
    }
    
    private var formattedYearString: String {
        if let date = date {
            date.formatted(.dateTime.year(.defaultDigits)) + "년"
        } else {
            "           년" // 4칸 공백 + 년
        }
    }
    
    private var formattedMonthString: String {
        if let date = date {
            date.formatted(.dateTime.month(.defaultDigits))
                .padding(toLength: 2, withPad: " ", startingAt: .zero) + "월"
        } else {
            "    월" // 2칸 공백 + 월
        }
    }
    
    private var formattedDayString: String {
        if let date = date {
            date.formatted(.dateTime.day(.defaultDigits))
                .padding(toLength: 2, withPad: " ", startingAt: .zero) + "일"
        } else {
            "    일" // 2칸 공백 + 월
        }
    }
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(title)
                    .font(.npsTitle12)
                if isRequired {
                    Text("*")
                        .font(.npsTitle12)
                        .foregroundStyle(AppResourceAsset.Color.lubbyBlue.swiftUIColor)
                }
            }
            
            VStack(spacing: 8) {
                HStack(spacing: .zero) {
                    Text(formattedYearString)
                        .font(.npsTitle12)
                    Spacer()
                    
                    Text(formattedMonthString)
                        .font(.npsTitle12)
                    Spacer()
                    
                    Text(formattedDayString)
                        .font(.npsTitle12)
                    Spacer()
                }
                .padding(.horizontal, 22)
                .overlay {
                    HStack(spacing: .zero) {
                        Spacer()
                        AppResourceAsset.Image.icChevronDown.swiftUIImage
                            .frame(width: 10, height: 6)
                            .padding(.trailing, 18)
                            .foregroundStyle(.black)
                    }
                }
                Rectangle()
                    .foregroundStyle(.black)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(.black)
            .overlay {
                VStack {
                    DatePicker(
                        selection: Binding(
                            get: { date ?? Date() },
                            set: { date = $0 }
                        ),
                        displayedComponents: .date
                    ) {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.clear)
                    }
                    .labelsHidden()
                    .colorMultiply(.clear)
                    .scaleEffect(x: 10, y: 1.5)
                    .compositingGroup()
                    .clipped()
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

public struct CuddleRadioContentView: View {
    @State var value: String
    var selectedValue: String?
    
    let action: () -> Void
    
    public init(value: String, selectedValue: String?, action: @escaping () -> Void) {
        self.value = value
        self.selectedValue = selectedValue
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                (value == selectedValue ? AppResourceAsset.Image.icRadioSelected.swiftUIImage : AppResourceAsset.Image.icRadioNormal.swiftUIImage)
                    .frame(width: 16, height: 16)
                Text(value)
                    .font(.npsTitle12)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
        }
        .background(.white)
        .buttonStyle(PlainButtonStyle())
    }
}

public protocol RadioContentRepresentable {
    var title: String { get }
}
