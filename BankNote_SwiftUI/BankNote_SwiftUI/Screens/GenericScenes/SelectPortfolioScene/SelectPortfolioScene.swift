//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct SelectPortfolioScene: BaseSceneType {
    @ObservedObject var viewModel: SelectPortfolioViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SelectPortfolioContentView(usersData: $viewModel.usersData, selectedUser: $viewModel.selectedUser, onConfirm: { user in
                    viewModel.onConfirm(user: user)
                }, onDismiss: {
                    viewModel.onDismiss()
                })
                .onAppear {
                    viewModel.getUsersData()
                }
            })
        })
    }
}
