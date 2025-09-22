//
//  PortfolioScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct PortfolioScene: BaseSceneType {
    @ObservedObject var viewModel: PortfolioViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                PortfolioContentView(portfolioData: $viewModel.portfolioData, pieChartData: $viewModel.pieChartData, onPortfolioTap: { symbol, marketType, custodianID, custodianName in
                    viewModel.openStockDetailsScene(symbol: symbol, marketType: marketType, custodianID: custodianID, custodianName: custodianName)
                })
            })
            .onAppear {
                viewModel.callGetPortfolioAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            portfolioAPI()

        }
    }
    
    private func portfolioAPI() {
        viewModel.$getPortfolioAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
