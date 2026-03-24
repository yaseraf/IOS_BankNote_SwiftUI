//
//  TransactionHistoryViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/03/2026.
//

import Foundation

class TransactionHistoryViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var transactionSummaryData: [GetTransactionSummaryUIModel]?
    
    @Published var getTransactionSummaryAPIResult:APIResultType<[GetTransactionSummaryUIModel]>?

    init(coordinator: HomeCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        transactionSummaryData = []
    }
    
}

// MARK: Routing
extension TransactionHistoryViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: Function
extension TransactionHistoryViewModel {
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        var dateComponents = DateComponents()
        dateComponents.day = -1
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
}

// MARK: API Calls
extension TransactionHistoryViewModel {
    func callGetTransactionSummaryAPI(success: Bool) {
                
        let requestModel = GetTransactionSummaryRequestModel()
        
        UserDefaultController().dateFrom = "-1"
        UserDefaultController().dateTo = getCurrentDateString()
        
        getTransactionSummaryAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getTransactionSummary(requestModel: requestModel) {[weak self] result in
                
                self?.getTransactionSummaryAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    
                    debugPrint("Success transaction summary")
                    
                    self?.getTransactionSummaryAPIResult = .onSuccess(response: success)
                    
                    self?.transactionSummaryData = success
                    
                case .failure(let failure):
                        debugPrint("Failed transaction summary")
                    
                        self?.getTransactionSummaryAPIResult = .onFailure(error: failure)
                }
            }
        }
    }

}
