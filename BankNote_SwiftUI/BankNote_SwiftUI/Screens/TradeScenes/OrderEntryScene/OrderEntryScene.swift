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
                OrderEntryContentView(symbol: $viewModel.symbol, netChange: $viewModel.netChange, netChangePerc: $viewModel.netChangePerc, lastTradePrice: $viewModel.lastTradePrice, onContinueTap: {
                    viewModel.openPaymentMethodScene()
                }, onBackTap: {
                    viewModel.popViewController()
                })
            })
            .onAppear {
                viewModel.GetCompaniesLookupsAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            companiesLookupAPI()
            marketWatchAPI()
        }
    }
    
    private func companiesLookupAPI() {
        viewModel.$getCompaniesLookupsAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func marketWatchAPI() {
        viewModel.$getAllMarketWatchBySymbolAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
