//
//  CuddlerInput.swift
//  ProfileFeature
//
//  Created by mvldev7 on 8/25/24.
//

import Foundation
import UIKit

import ComposableArchitecture

public enum ImageStatus: Equatable {
    case url(URL)
    case preRegistration(UIImage)
    case none
    
    var images: [UIImage] {
        switch self {
        case .url, .none: []
        case let .preRegistration(image): []
        }
    }
}

@Reducer
public struct CuddlerInput {
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case back
        case confirm
    }
    
    @ObservableState
    public struct State: Equatable {
        public var title: String
        public var image: ImageStatus
        public var name: String
        public var birth: Date
        public var kind: String
        public var gender: GenderModel?
        public var weight: Double
        public var description: String?
        public var withDate: Date
        public var endDate: Date?
        
        public init(inputType: CuddlerProfileInputType) {
            self.title = inputType.title
            self.image = if let imageURL = inputType.cuddler?.imageURL {
                .url(imageURL)
            } else {
                .none
            }
            self.name = inputType.cuddler?.name ?? ""
            self.birth = inputType.cuddler?.birth ?? Date()
            self.kind = inputType.cuddler?.kind ?? ""
            self.gender = inputType.cuddler?.gender
            self.weight = inputType.cuddler?.weight ?? .zero
            self.description = inputType.cuddler?.description
            self.withDate = inputType.cuddler?.withDate ?? Date()
            self.endDate = inputType.cuddler?.endDate
        }
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            return .none
        }
    }
}
