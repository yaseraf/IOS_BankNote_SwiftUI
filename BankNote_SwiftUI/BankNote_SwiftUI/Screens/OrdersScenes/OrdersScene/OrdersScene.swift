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
                OrdersContentView(ordersData: $viewModel.ordersData, filterOSSList: $viewModel.filterOSSList, onOrderTap: { symbol in
                    viewModel.openOrderEntryScreen(symbol: symbol)
                })
            })
            .onAppear {
                viewModel.getOrdersData()
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad(){
            sendOrdersSignalR()
        }
    }
    
    private func sendOrdersSignalR() {
        viewModel.$sendOrdersAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                
            case .none:
                break
            }
            
        }.store(in: &anyCancellable)
    }
}
