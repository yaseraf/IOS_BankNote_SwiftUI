//
//  OrderEntryScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct OrderEntryScene: BaseSceneType {
    @ObservedObject var viewModel: OrderEntryViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                OrderEntryContentView(onContinueTap: {
                    viewModel.openPaymentMethodScene()
                }, onBackTap: {
                    viewModel.popViewController()
                })
            })
        })
    }
}
