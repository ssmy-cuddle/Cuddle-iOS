//
//  View+NavigationBar.swift
//  UIComponent
//
//  Created by mvldev7 on 9/15/24.
//

import Foundation
import SwiftUI

public extension View {
    func isNavigationBarVisible(_ isVisible: Bool) -> some View {
        if isVisible {
            self.navigationBarHidden(false)
            self.navigationBarBackButtonHidden(false)
        } else {
            self.navigationBarTitle("", displayMode: .inline) //this must be empty
            self.navigationBarHidden(true)
            self.navigationBarBackButtonHidden(true)
        }
        return self
    }
}
