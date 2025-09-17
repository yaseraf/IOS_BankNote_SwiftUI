//
//  HomeScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct HomeScene: BaseSceneType {
    @ObservedObject var viewModel: HomeViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                HomeContentView(portfolioData: $viewModel.portfolioData, onTopUpTap: {
                    viewModel.openTopUpScene(transactionType: .topUp)
                }, onWithdrawalTap: {
                    viewModel.openTopUpScene(transactionType: .withdrawal)
                })
            })
            .onAppear {
                viewModel.callGetUserAccountsAPI(success: true)
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
