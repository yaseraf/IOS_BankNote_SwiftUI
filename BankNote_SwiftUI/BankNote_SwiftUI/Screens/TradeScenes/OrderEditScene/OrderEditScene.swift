//
//  OrderEditScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/10/2025.
//

import Foundation
import SwiftUI
import Combine

struct OrderEditScene: BaseSceneType {
    @ObservedObject var viewModel: OrderEditViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                OrderEditContentView(orderDetails: $viewModel.orderDetails, onEditTap: {
                    viewModel.editOrder()
                }, onCancelTap: {
                    viewModel.cancelOrder()
                }, onDismiss: {
                    viewModel.dismiss()
                })
            })
        })
    }
}
