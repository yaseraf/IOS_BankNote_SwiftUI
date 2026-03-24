//
//  StatementViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/03/2026.
//

import Foundation

class StatementsViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var listMyStatement:[GetStatementOfAccountUIModel]?

    @Published var getStatementOfAccountAPIResult:APIResultType<[GetStatementOfAccountUIModel]>?

    init(coordinator: SettingsCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}

// MARK: Routing
extension StatementsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: Functions
extension StatementsViewModel {
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")   // Force English digits
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func getYesterdayDateString() -> String {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
//            if let firstDayOfCurrentYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)),
            if let oneMonthBefore = calendar.date(byAdding: .month, value: -1, to: Date()) {
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateFormat = "ddMMyyyyHHmmss"
                formatter.locale = Locale(identifier: "en_US_POSIX")
                return formatter.string(from: oneMonthBefore)
            }
        
          
            return ""
    }

}

// MARK: API Calls
extension StatementsViewModel {
    func callGetStatementOfAccountAPI(success: Bool) {
        
        if UserDefaultController().dateFrom == "" || UserDefaultController().dateFrom == nil {
            UserDefaultController().dateFrom = getYesterdayDateString()
        }
        
        if UserDefaultController().dateTo == "" || UserDefaultController().dateTo == nil {
            UserDefaultController().dateTo = getCurrentDateString()
        }
                
        let requestModel = GetStatementOfAccountRequestModel()
        getStatementOfAccountAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getStatementOfAccount(requestModel: requestModel) {[weak self] result in
                self?.getStatementOfAccountAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("Success to get statement account")

                        self?.getStatementOfAccountAPIResult = .onSuccess(response: success)
                        self?.listMyStatement = success

                case .failure(let failure):
                        debugPrint("Failed to get statement of account")
                        self?.getStatementOfAccountAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
}
