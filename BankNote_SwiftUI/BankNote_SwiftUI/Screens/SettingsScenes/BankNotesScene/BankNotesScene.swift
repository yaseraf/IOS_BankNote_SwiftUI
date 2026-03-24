//
//  BankNotesScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct BankNotesScene: BaseSceneType {
    @ObservedObject var viewModel: BankNotesViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            backgroundType: .clear,
            contentView: {
                BaseContentView(
                    withScroll: false,
                    paddingValue: 0,
                    backgroundType: .gradient,
                    content: {
                        BankNotesContentView(
                            bankNotesData: $viewModel.bankNotesData,
                            clientBankNotes: $viewModel.clientBankNotes,
                            selectedPrice: $viewModel.selectedPrice,
                            selectedQuantity: $viewModel.selectedQuantity,
                            viewController: $viewModel.viewController,
                            topUpItems: $viewModel.topUpItems,
                            rewardsItems: $viewModel.rewardsItems,
                            onBackTap: {
                                viewModel.popViewController()
                            }, onTopUpTap: {
                                viewModel.openTopUpScene()
                            }, onBuyBankNotes: { item in
                                viewModel.callCreateBuyBankNotesJVAPI(success: true, price: item.price ?? "", qty: item.bankNoteQty ?? "")
                            }
                        )
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onAppear {
            viewModel.callGetBankNotesAPI(success: true)
            viewModel.callGetClientBankNotesAPI(success: true)
//            viewModel.getRiskManagementAPI(success: true)
        }
        .onViewDidLoad {
            getBankNotesAPI()
            getClientBankNotesAPI()
        }
    }
    
    private func getBankNotesAPI() {
        viewModel.$getBankNotesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
