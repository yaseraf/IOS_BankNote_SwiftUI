//
//  TopUpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation

class TopUpViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    private let homeUseCase: HomeUseCaseProtocol
    
    private let paymobApiKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBNE56WXlNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5XcnFoSWpJalByZFpaeU1KY3dOdjJuMWdwbU9SS1F4SXJCaVcyZ0x0UWdHNDV5eGJBd200UEtFbll4TmlxY2tleDVXamU1dUo5NUNEQ1FZa0xyQWFmQQ=="
    
    @Published var getPaymobAuthorizeAPIResult:APIResultType<PaymobAuthorizeUIModel>?

    @Published var transactionTypes: TransactionTypes?
    
    @Published var paymobData: PaymobAuthorizeUIModel = .initializer()
    
    init(coordinator: HomeCoordinatorProtocol, transactionTypes: TransactionTypes?, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
        
        self.transactionTypes = transactionTypes
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        coordinator.openPaymentMethodScene(transactionType: transactionTypes ?? .topUp)
    }
}

// MARK: API Calls
extension TopUpViewModel {
    func callPaymobAuthorizeAPI(success:Bool) {
        let requestModel = PaymobAuthorizeRequestModel(
            ApiKey: paymobApiKey,
            Signature: "",
            Payload: ""
        )

        getPaymobAuthorizeAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.PaymobAuthorize(requestModel: requestModel) {[weak self] result in
                self?.getPaymobAuthorizeAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getPaymobAuthorizeAPIResult = .onSuccess(response: success)
                    debugPrint("get paymob authorize success")
                    self?.paymobData = success
                    
                case .failure(let failure):
                        self?.getPaymobAuthorizeAPIResult = .onFailure(error: failure)
                    debugPrint("get paymob authorize failed")
                }
            }
        }
    }
}
