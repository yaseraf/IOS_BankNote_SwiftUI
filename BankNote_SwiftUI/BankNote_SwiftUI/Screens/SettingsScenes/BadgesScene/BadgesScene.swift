//
//  BadgesScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct BadgesScene: BaseSceneType {
    @ObservedObject var viewModel: BadgesViewModel
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
                        BadgesContentView(
                            badgesData: $viewModel.badgesData,
                            tiersData: $viewModel.tiersData,
                            userBadgesData: $viewModel.userBadgesData,
                            onBackTap: {
                                viewModel.popViewController()
                            }
                        )
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onAppear {
            viewModel.callGetTiersAPI(success: true)
            viewModel.callGetBankNotesMainBadgesAPI(success: true)
            viewModel.callGetBankNotesBadgesAPI(success: true)
        }
        .onViewDidLoad {
            getTiersAPI()
            getBankNotesBadgesAPI()
            getBankNotesMainBadgesAPI()
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
    
    private func getBankNotesBadgesAPI() {
        viewModel.$getBankNotesBadgesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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

    
    private func getBankNotesMainBadgesAPI() {
        viewModel.$getBankNotesMainBadgesAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
