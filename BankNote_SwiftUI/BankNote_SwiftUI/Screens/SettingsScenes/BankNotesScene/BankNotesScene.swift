//
//  BankNotesScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct BankNotesScene: BaseSceneType {
    @ObservedObject var viewModel: BankNotesViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                BankNotesContentView(topUpItems: $viewModel.topUpItems, rewardsItems: $viewModel.rewardsItems, onBackTap: {
                    viewModel.popViewController()
                }, onTopUpTap: {
                    viewModel.openPaymentMethodScene()
                })
            })
        })
    }
}
