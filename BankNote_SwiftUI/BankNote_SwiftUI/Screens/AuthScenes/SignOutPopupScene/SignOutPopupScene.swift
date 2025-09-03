//
//  SignOutPopupScene.swift
//  mahfazati
//
//  Created by Mohammmed on 05/09/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import SwiftUI
import Combine

struct SignOutPopupScene: View {
    @ObservedObject private var viewModel: SignOutPopupViewModel
    @State private var anyCancellable = Set<AnyCancellable>()
    @State private var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    init(viewModel: SignOutPopupViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false,paddingValue:0,paddingVerticalValue: 0, content: {
                SignOutPopupContentView(onDoneTap: {
                    viewModel.UsersLogOffAPI(success: true)
                }, onCancelTap: {
//                    viewModel.dismiss()
                }, onCloseTap: {
//                    viewModel.dismiss()
                })

            })



        }, showLoading: .constant(viewTypeAction.showLoading))
        .background(Color.clear)

        .ignoresSafeArea()

    }


}
