//
//  SplashScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import SwiftUI

struct SplashScene: View {
     @ObservedObject  private var viewModel: SplashViewModel

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SplashContentView()
                    .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        viewModel.openLoginScene()
                    }
                })
            })
        })
    }
}
