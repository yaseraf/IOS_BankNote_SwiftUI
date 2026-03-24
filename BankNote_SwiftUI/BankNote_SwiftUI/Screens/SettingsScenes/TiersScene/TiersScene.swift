//
//  TiersScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct TiersScene: BaseSceneType {
    @ObservedObject var viewModel: TiersViewModel
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
                        TiersContentView(
                            tiersData: $viewModel.tiersData,
                            clientBankNotes: $viewModel.clientBankNotes,
                            showInsufficientFunds: $viewModel.showInsufficientFunds,
                            tiers: $viewModel.tiers,
                            onBackTap: {
                                viewModel.popViewController()
                            },
                            onTierPurchase: { qty, tiersCode in
                                viewModel.BuyTier(qty: qty, tiersCode: tiersCode)
                            },
                            onTopupTap: {
                                viewModel.openBankNotesScene()
                            }
                        )
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onAppear {
            viewModel.callGetTiersAPI(success: true)
            viewModel.callGetClientBankNotesAPI(success: true)
        }
        .onViewDidLoad {
            getTiersAPI()
            updateTiersCodeAPI()
        }
    }
    
    private func getTiersAPI() {
        viewModel.$getTiersAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func updateTiersCodeAPI() {
        viewModel.$updateTiersCodeAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
