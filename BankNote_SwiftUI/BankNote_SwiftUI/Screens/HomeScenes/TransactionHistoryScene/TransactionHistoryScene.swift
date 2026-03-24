//
//  TransactionHistoryScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/03/2026.
//

import Foundation
import SwiftUI
import Combine

struct TransactionHistoryScene: BaseSceneType {
    @ObservedObject var viewModel: TransactionHistoryViewModel
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
                        TransactionHistoryContentView(
                            transactionSummaryData: $viewModel.transactionSummaryData,
                            onBackTap: viewModel.popViewController
                        )
                    }
                )
                .onAppear {
                    viewModel.callGetTransactionSummaryAPI(success: true)
                }
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
            GetTransactionSummaryAPI()
        }
    }
        
    private func GetTransactionSummaryAPI() {
        viewModel.$getTransactionSummaryAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
