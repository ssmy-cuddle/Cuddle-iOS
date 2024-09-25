//
//  ConfirmPopupView.swift
//  CommunityFeature
//
//  Created by mvldev7 on 9/20/24.
//

import Foundation
import SwiftUI

import DesignSystem

import PopupView

public struct ConfirmPopupView: View {
    
    private let title: String
    private let confirmAction: () -> Void
    private let cancelAction: () -> Void
    
    public init(title: String, confirmAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
        self.title = title
        self.confirmAction = confirmAction
        self.cancelAction = cancelAction
    }
    
    public var body: some View {
        ZStack{
            VStack(spacing: 16) {
                Text(title)
                    .font(.pretendardTitle16)
                
                HStack(spacing: 12) {
                    CuddleTextButton(
                        action: cancelAction,
                        theme: .primary(.blue),
                        text: "아니요",
                        font: .pretendardBody10
                    )
                    CuddleTextButton(
                        action: confirmAction,
                        theme: .primary(.yellow),
                        text: "예",
                        font: .pretendardBody10
                    )
                }
            }
            .padding(.horizontal, 54)
            .padding(.vertical, 36)
        }
        .background(
            Rectangle()
                .clipShape(.rect(cornerRadius: 10))
                .foregroundStyle(.white)
                .shadow(
                    color: .black.opacity(0.04),
                    radius: 35,
                    x: 0,
                    y: 2
                )
                .padding(.horizontal, 24)
        )
    }
}
