//
//  InvoicesViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/03/2026.
//

import Foundation

class InvoicesViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var listMyInvoices:GetInvoicesUIModel?

    @Published var getInvoicesAPIResult: APIResultType<GetInvoicesUIModel>?

    init(coordinator: SettingsCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}

// MARK: Routing
extension InvoicesViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension InvoicesViewModel {
    func callGetInvoicesAPI(success:Bool) {
        
        let requestModel = GetInvoicesRequestModel(clientID: KeyChainController.shared().clientID, dateFrom: UserDefaultController().dateFrom, dateto: UserDefaultController().dateTo, webCode: KeyChainController.shared().webCode)
        
        getInvoicesAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.getInvoices(requestModel: requestModel) {[weak self] result in
                self?.getInvoicesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                        self?.getInvoicesAPIResult = .onSuccess(response: success)
                        self?.listMyInvoices = success
                    debugPrint("Get Invoices API Success")
                    
                case .failure(let failure):
                        self?.getInvoicesAPIResult = .onFailure(error: failure)
                    debugPrint("Get Invoices API Failed")
               
                }
            }
        }
    }
}
