//
//  OrdersScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct OrdersScene: BaseSceneType {
    @ObservedObject var viewModel: OrdersViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                OrdersContentView(ordersData: $viewModel.ordersData)
            })
            .onAppear {
                viewModel.getOrdersData()
            }
        })
    }
}
