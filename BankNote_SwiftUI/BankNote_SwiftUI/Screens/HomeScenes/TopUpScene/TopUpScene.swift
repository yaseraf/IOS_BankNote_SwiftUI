//
//  TopUpScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct TopUpScene: BaseSceneType {
    @ObservedObject var viewModel: TopUpViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            backgroundType: .clear,
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    backgroundType: .gradient,
                    content: {
                        TopUpContentView(
                            transactionType: $viewModel.transactionTypes,
                            viewController: $viewModel.viewController,
                            onContinueTap: { amount in
                                viewModel.callGetPaymobAPI(success: true, amount: amount)
                            }, onBackTap: {
                                viewModel.popViewController()
                            }
                        )
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)

        )
        .onViewDidLoad {
            paymobAPI()
        }
    }
    
    private func paymobAPI() {
        viewModel.$getPaymobAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                debugPrint("")
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }
}
