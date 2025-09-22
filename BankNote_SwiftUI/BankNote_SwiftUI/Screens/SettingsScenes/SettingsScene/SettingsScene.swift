//
//  SettingsScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct SettingsScene: BaseSceneType {
    @ObservedObject var viewModel: SettingsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                SettingsContentView(onBankNotesTap: {
                    viewModel.openBankNotesScene()
                }, onTiersTap: {
                    viewModel.openTiersScene()
                }, onBadgesTap: {
                    viewModel.openBadgesScene()
                }, onHelpTap: {
                    viewModel.openHelpScene()
                }, onLogoutTap: {
                    viewModel.UsersLogOffAPI(success: true)
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            logoutAPI()
        }

    }
    
    private func logoutAPI() {
        viewModel.$usersLogOffAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
