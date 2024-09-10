//
//  Daily.swift
//  CommunityFeature
//
//  Created by mvldev7 on 8/5/24.
//

import Foundation
import SwiftUI

import BaseFeature
import CommunityClient

import ComposableArchitecture

@Reducer
public struct Daily {
    
    @Dependency(\.getDailyContentsUseCase) private var getDailyContentsUseCase
    @Dependency(\.likeDailyUseCase) private var likeDailyUseCase
    
    public enum Action: FeatureAction, Equatable {
        case view(ViewAction)
        case inner(InnerAction)
        case delegate(DelegateAction)
        
        public enum ViewAction: Equatable {
            case onAppear
            case writeComment
            case like(UUID, isLike: Bool)
        }
        
        public enum InnerAction: Equatable {
            case contents([DailyContentModel])
            case update(DailyContentModel, index: Int)
            case loading(Bool)
        }
        
        public enum DelegateAction: Equatable {
            case refresh
        }
    }
    
    @ObservableState
    public struct State: Equatable {
        var contents: [DailyContentModel] = []
        var isLoading: Bool = false
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .view(.onAppear): 
                return onAppear(state: &state)
            case let .view(.like(id, isLike)):
                return self.like(id: id, isLike: isLike, state: &state)
            case let .inner(.contents(contents)):
                return self.contents(contents, state: &state)
            case let .inner(.loading(isLoading)):
                state.isLoading = isLoading
                return .none
            case let .inner(.update(daily, index: index)): 
                return self.update(daily: daily, at: index, state: &state)
            case .delegate(.refresh):
                return refresh(state: &state)
            default:
                return .none
            }
        }
    }
}

extension Daily {
    
    private func onAppear(state: inout State) -> Effect<Action> {
        state.isLoading = true
        return .run { send in
            await send(.inner(.loading(true)))
            let contents = try await getDailyContentsUseCase.execute().map { $0.asModel }
            //            return await send(.inner(.contents(contents)))
            return await send(.inner(.contents(contents)))
        }
    }
    
    private func contents(
        _ contents: [DailyContentModel],
        state: inout State
    ) -> Effect<Action> {
        state.contents = contents
        state.isLoading = false
        return .run { send in
            await send(.inner(.loading(false)))
        }
    }
    
    private func update(
        daily: DailyContentModel,
        at index: Int,
        state: inout State
    ) -> Effect<Action> {
        var localState = state
        localState.contents.remove(at: index)
        localState.contents.insert(daily, at: index)
        state.contents = localState.contents
        return .none
    }
    
    private func like(
        id: UUID,
        isLike: Bool,
        state: inout State
    ) -> Effect<Action> {
        let localState = state
        return .run {
            let daily = try await likeDailyUseCase.execute(
                parameters: .init(id: id, isLike: isLike)
            ).asModel
            if let index = localState.contents.firstIndex(where: { $0.id == id }) {
                return await $0(.inner(.update(daily, index: index)))
            }
            return await $0(.inner(.contents(localState.contents)))
        }
    }
    
    private func refresh(state: inout State) -> Effect<Action> {
//        state.isLoading = true
        return .run { send in
            let contents = try await getDailyContentsUseCase.execute().map { $0.asModel }
            //            return await send(.inner(.contents(contents)))
            return await send(.inner(.contents(contents)))
        }
    }
}
//
//extension DailyContentModel {
//    static let mockDailys: [DailyContentModel] = [
//        .init(
//            id: UUID(),
//            imageURLs: [
//                URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
//                URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
//                URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
//                URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
//            ], 
//            likeCounts: 16,
//            messageCounts: 4,
//            nickname: "건우",
//            profileIageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
//            description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
//            createdAt: Date().addingTimeInterval(-120)
//        ),
//        .init(
//            id: UUID(),
//            imageURLs: [
//                URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
//                URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
//                URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
//                URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
//            ],
//            likeCounts: 16,
//            messageCounts: 4,
//            nickname: "건우",
//            profileIageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
//            description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
//            createdAt: Date().addingTimeInterval(-120)
//        ),
//        .init(
//            id: UUID(),
//            imageURLs: [
//                URL(string: "https://fastly.picsum.photos/id/946/584/556.jpg?hmac=8_2-LFi4r-T9YeerjAeOazV6AsYlH9MZjsJ0h63TJ4c")!,
//                URL(string: "https://fastly.picsum.photos/id/181/584/556.jpg?hmac=0qAjxY88ACXz56xbVqfl0nYF2DL5gSlPpTAyQIjRryA")!,
//                URL(string: "https://fastly.picsum.photos/id/986/584/556.jpg?hmac=zRryzjbjrjJ2fyjlrd2Mlo7dfIQQd_uEFkEMhhaCJDY")!,
//                URL(string: "https://fastly.picsum.photos/id/668/584/556.jpg?hmac=fxQ9FgTL5SsFbwVo9zOQi56fQ-ktd8GpShnJg96-ubo")!
//            ],
//            likeCounts: 16,
//            messageCounts: 4,
//            nickname: "건우",
//            profileIageURL: URL(string: "https://fastly.picsum.photos/id/626/60/60.jpg?hmac=UqDAZSDUUq8-bJC4kOlIC3TlkbQxb4cFUSBia7JQBk8")!,
//            description: "집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다 집에 가고싶다",
//            createdAt: Date().addingTimeInterval(-120)
//        )
//    ]
//}
