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
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                TiersContentView(tiersData: $viewModel.tiersData, tiers: $viewModel.tiers, onBackTap: {
                    viewModel.popViewController()
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onAppear {
            viewModel.callGetTiersAPI(success: true)
        }
        .onViewDidLoad {
            getTiersAPI()
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

}
