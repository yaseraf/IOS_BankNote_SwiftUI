//
//  OrderDetailsScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 22/10/2025.
//

import Foundation
import SwiftUI
import Combine

struct OrderDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: OrderDetailsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                OrderDetailsContentView(orderPreview: $viewModel.orderPreview,
                onCancelTap: {
                    viewModel.popViewController()
                }, onPlaceOrderTap: {
                    viewModel.setOrder()
                }, onBackTap: {
                    viewModel.popViewController()
                })
            })
            .onAppear {

            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            SendOrderAPI()
        }
    }
    
    private func SendOrderAPI() {
        viewModel.$sendOrdersAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result {
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("Loading..")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }
}
