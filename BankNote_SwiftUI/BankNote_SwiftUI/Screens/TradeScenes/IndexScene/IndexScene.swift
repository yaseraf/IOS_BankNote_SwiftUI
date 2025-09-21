//
//  IndexScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct IndexScene: BaseSceneType {
    @ObservedObject var viewModel: IndexViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                IndexContentView(indexData: $viewModel.listMarketOverView, onBackTap: {
                    viewModel.popViewController()
                })
                .onAppear {
                    viewModel.GetExchangeSummaryAPI(success: true)
                }
            })
           
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            ExchangeDataAPI()
        }
    }
    
    private func ExchangeDataAPI() {
        viewModel.$getExchangeSummaryAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
