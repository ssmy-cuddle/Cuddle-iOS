//
//  AppContainer.swift
//  Cuddle
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation

import ComposableArchitecture
import Swinject
import SwinjectAutoregistration

enum AppContainer {
    static var shared: Container = {
        let container = Container()
        let assembler = Assembler(container: container)
        
        container.register(ContentView.self) { resolver in
            ContentView(store: StoreOf<Content>(initialState: Content.State()) {
                Content()
            })
        }
        
        return container
    }()
}
