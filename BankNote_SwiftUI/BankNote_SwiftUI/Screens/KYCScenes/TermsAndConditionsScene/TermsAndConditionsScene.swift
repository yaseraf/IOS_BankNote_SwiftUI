//
//  TermsAndConditionsScene.swift
//  mahfazati
//
//  Created by FIT on 16/03/2025.
//  Copyright © 2025 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct TermsAndConditionsScene: BaseSceneType{
    @ObservedObject var viewModel: TermsAndConditionsViewModel
    @State var anyCancellable = Set<AnyCancellable>()

    @State var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    var body: some View {
        BaseScene(backgroundType: .colorBGSecondary,contentView: {
            BaseContentView(withScroll:false, backgroundType: .colorBGSecondary, content: {
                TermsAndConditionsContentView(htmlContent: $viewModel.htmlContent, onContinueTap:   {
                    
                    viewModel.activateBusinessRequestAPI(success: true)

//                    if UserDefaultController().investmentProductKeys?.isEmpty == false {
//                        viewModel.openTermsAndConditionsScene()
//                    } else {
//                        viewModel.activateBusinessRequestAPI(success: true)
//                    }
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onAppear {
            
            let completed = UserDefaultController().completedInvestmentProductKeys ?? [:]

            // Get all ids with status "4" (Customer signed) / "3" (Approved)
            let signedContracts = completed
                .filter { $0.value != "3"} // Ignore all contracts except "Approved"
                .map { $0.key }

            
            // if the contract is approved call getCurrentBusinessRequest directly, else call createBusinessRequest
            if signedContracts.contains(UserDefaultController().investmentProductKeys?.first ?? "") {
                viewModel.getCurrentBusinessRequestListAPI(success: true)
            } else {
                viewModel.createBusinessRequestAPI(success: true, requestFieldsValues: [])
            }
        }
        .onViewDidLoad(){
            createBusinessRequest()
            loginAdmin()
            approveOrReject()
            getCurrentBusinessRequestList()
        }

    }

    private func createBusinessRequest() {
        viewModel.$createBusinessRequestAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                
            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
    private func loginAdmin() {
        viewModel.$loginAdminAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
    private func approveOrReject() {
        viewModel.$approveOrRejectAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
    private func getCurrentBusinessRequestList() {
        viewModel.$getCurrentBusinessRequestListAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
}
