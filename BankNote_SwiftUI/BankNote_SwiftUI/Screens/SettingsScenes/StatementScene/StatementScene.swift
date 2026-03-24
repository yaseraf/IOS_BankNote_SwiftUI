//
//  StatementScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/03/2026.
//

import Foundation
import SwiftUI
import Combine

struct StatementsScene: BaseSceneType {
    @ObservedObject var viewModel: StatementsViewModel
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
                        StatementsContentView(
                            listMyStatements: $viewModel.listMyStatement,
                            onBackTap: {
                                viewModel.popViewController()
                            }
                        )
                    }
                )
                .onAppear {
                    viewModel.callGetStatementOfAccountAPI(success: true)
                }
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
            StatementsAPI()
        }
    }
    
    private func StatementsAPI() {
        viewModel.$getStatementOfAccountAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
