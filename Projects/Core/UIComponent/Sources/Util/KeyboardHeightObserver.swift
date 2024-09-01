//
//  KeyboardHeightObserver.swift
//  UIComponent
//
//  Created by mvldev7 on 9/1/24.
//

import Combine
import Foundation
import SwiftUI

public final class KeyboardObserver: ObservableObject {
    @Published public var keyboardHeight: CGFloat = 0
    @Published public var isKeyboardVisible: Bool = false

    private var cancellables = Set<AnyCancellable>()

    public init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            }
            .map { $0.height }
            .sink { [weak self] height in
                self?.keyboardHeight = height
                self?.isKeyboardVisible = true
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                self?.keyboardHeight = 0
                self?.isKeyboardVisible = false
            }
            .store(in: &cancellables)
    }
}
