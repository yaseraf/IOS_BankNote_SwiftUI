//
//  QuestioneerScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct QuestioneerScene: BaseSceneType {
    @ObservedObject var viewModel: QuestioneerViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                QuestioneerContentView(fieldValues: $viewModel.kycFieldsValues, kycFieldsData: $viewModel.kycFieldsData, showContract: $viewModel.showContract, contractURL: $viewModel.contractURL, selectContractsItemPicker: $viewModel.selectContractsItemPicker, onConfirmTap: {
                    viewModel.getContractValifyAPI(success: true)
                }, onContractsTap: {
                    viewModel.openContractsScene()
                }, onEndContractSigning: {
                    viewModel.openThanksForRegisteringScene()
                })
            })
            .onAppear {
                viewModel.getKycFieldValifyAPI(success: true)
                viewModel.getKycContractValifyAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            getKycFieldsValifyAPI()
            getKycContractValifyAPI()
            getContractValifyAPI()
        }
    }
    
    private func getKycFieldsValifyAPI() {
        viewModel.$getKycFieldAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getKycContractValifyAPI() {
        viewModel.$getKycContractAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getContractValifyAPI() {
        viewModel.$getContractAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
