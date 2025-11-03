//
//  ViewDidLoadModifier.swift
//  QSC
//
//  Created by FIT on 01/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

    
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}
