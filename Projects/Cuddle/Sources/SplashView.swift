//
//  SplashView.swift
//  Cuddle
//
//  Created by mvldev7 on 7/6/24.
//

import Foundation
import SwiftUI

import AppResource
import DesignSystem

public struct SplashView: View {
    
    public init() {}

    public var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center) {
                Image(uiImage: AppResourceAsset.Image.cuddleMainLogo.image)
                Text("Cuddle")
                    .font(.custom(NPS.header.name, size: 36))
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
