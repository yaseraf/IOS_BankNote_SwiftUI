//
//  BankNotesScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct BuyTransactionsScene: BaseSceneType {
    @ObservedObject var viewModel: BuyTransactionsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                BuyTransactionsContentView(transactionsPackagesData: $viewModel.transactionsPackagesData, clientTransactions: $viewModel.clientTransactions, clientBankNotes: $viewModel.clientBankNotes, topUpItems: $viewModel.topUpItems, rewardsItems: $viewModel.rewardsItems, onBackTap: {
                    viewModel.popViewController()
                }, onTopUpTap: {
                    viewModel.openBankNotesScene()
                }, onPurchaseTransaction: {
                    viewModel.onPurchaseTransaction()
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onAppear {
            viewModel.callGetTransactionsPackagesAPI(success: true)
            viewModel.callGetClientTransactionsPackagesAPI(success: true)
            viewModel.callGetClientBankNotesAPI(success: true)
        }
        .onViewDidLoad {
            getTransactionsPackagesAPI()
            getClientTransactionsPackagesAPI()
            getClientBankNotesAPI()
        }
    }
    
    private func getTransactionsPackagesAPI() {
        viewModel.$getTransactionsPackagesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getClientTransactionsPackagesAPI() {
        viewModel.$getClientTransactionsPackagesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getClientBankNotesAPI() {
        viewModel.$getClientBankNotesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
