//
//  LivenessCheckViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import UIKit
import SwiftUI

class LivenessCheckViewModel: ObservableObject {
        
    private let coordinator: AuthCoordinatorProtocol
    private let valifyUseCase: ValifyUseCaseProtocol

    @Published var getValifyDataAPIResult:APIResultType<GetValifyDataUIModel>?

    @Published var startLivenessAPIResult:APIResultType<VerifyLivenessUIModel>?

    init(coordinator: AuthCoordinatorProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.valifyUseCase = valifyUseCase
        
        sdkIntegration.shared.LivenessDelegate = self
    }
    
}

// MARK: Routing
extension LivenessCheckViewModel {
    func openQuestioneerScene() {
        coordinator.openQuestioneerScene()
    }
    
    func openLoginInformationScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getAuthCoordinator(startViewType: .register).openLoginInformationScene()
    }
}

// MARK: API Calls
extension LivenessCheckViewModel {
    func getValifyData() {
        
        let requestModel = GetValifyDataRequestModel(reqID: KeyChainController().valifyRequestId ?? "")
                
        getValifyDataAPIResult = .onLoading(show: true)
        
        Task.init {
            await valifyUseCase.GetValifyData(requestModel: requestModel) {[weak self] result in
                self?.getValifyDataAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):

                    KeyChainController().valifyTransactionId = success.resData?.transactionId
                    debugPrint("get valify success")
                    
                case .failure(let failure):
                    self?.getValifyDataAPIResult = .onFailure(error: failure)
                    debugPrint("get valify failed: \(failure)")
                }
            }
        }
    }
}

// MARK: Functions
extension LivenessCheckViewModel {
    
}

// MARK: Delegates
extension LivenessCheckViewModel: LivenessResultDelegate {
    func onLivenessSuccess() {
        openLoginInformationScene()
    }
}
