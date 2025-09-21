//
//  HomeViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var portfolioData: GetPortfolioUIModel?
    @Published var transactionType: TransactionTypes?
    
    @Published var getUserAccountsAPIResult:APIResultType<[GetUserAccountsUIModel]>?
    @Published var getPortfolioAPIResult:APIResultType<GetPortfolioUIModel>?
    @Published var getCompaniesLookupsAPIResult:APIResultType<[GetCompaniesLookupsUIModel]>?

    
    init(coordinator: HomeCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        connectAndSetupSignalR()
    }
    
    func connectAndSetupSignalR() {
        if !Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.setupHubSignalR()
            Connection_Hub.shared.connection?.start()
        }
    }
}


// MARK: Mock Data
extension HomeViewModel {
    func getPortfolioData() {
//        var data: [PortfolioUIModel] = []
//        
//        data.append(PortfolioUIModel(image: "ic_adnocdistStock", name: "ADNOCDIST", price: 3.85, change: 0.45, changePerc: 1.25))
//        data.append(PortfolioUIModel(image: "ic_nvidiaStock", name: "NVIDIA", price: 650.50, change: 25.00, changePerc: -2.10))
//        data.append(PortfolioUIModel(image: "ic_fabStock", name: "FAB", price: 7.50, change: 0.80, changePerc: 0.45))
//        data.append(PortfolioUIModel(image: "ic_teslaStock", name: "Tesla", price: 890.00, change: 12.10, changePerc: 1.35))
//        
//        portfoliosData = data
    }
}

// MARK: Routing
extension HomeViewModel {
    func openTopUpScene(transactionType: TransactionTypes) {
        coordinator.openTopUpScene(transactionType: transactionType)
    }
}

// MARK: API Calls
extension HomeViewModel {
    func callGetUserAccountsAPI(success: Bool) {
                
        let requestModel = GetUserAccountsRequestModel()
        
        getUserAccountsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getUserAccounts(requestModel: requestModel) {[weak self] result in

                switch result {
                case .success(let success):
                        self?.getUserAccountsAPIResult = .onSuccess(response: success)
                    
                    if KeyChainController.shared().clientID != nil && KeyChainController.shared().clientID != "" && KeyChainController.shared().mainClientID != nil && KeyChainController.shared().mainClientID != "" && UserDefaultController().selectedUserAccount?.AccType != "all" {
                        self?.callGetPortfolioAPI(success: true)
                        debugPrint("Calling portfolio 1")
                    }
                    
                    if UserDefaultController().selectedUserAccount == nil ||  UserDefaultController().selectedUserAccount?.ClientID == "" || UserDefaultController().selectedUserAccount?.AccType == "all" {
                        for item in success {
                            if item.IS_DEFAULT_ACC == "Y" {
                                UserDefaultController().selectedUserAccount = item
                                KeyChainController.shared().clientID = item.ClientID
                                KeyChainController.shared().mainClientID = item.MainClientID
                                KeyChainController.shared().accountID = item.AccountID
                                self?.callGetPortfolioAPI(success: true)
                                debugPrint("Calling portfolio 2")
                            }
                        }
                    }
                                        
                    debugPrint("Get user accounts success")
                    
                case .failure(let failure):
                        self?.getUserAccountsAPIResult = .onFailure(error: failure)
                    debugPrint("Get user accounts failure")
                }
            }
        }
        
        
    }
    
    func callGetPortfolioAPI(success: Bool) {
                
        let requestModel = GetPortfolioRequestModel()
        
        getPortfolioAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getPortfolio(requestModel: requestModel) {[weak self] result in
                
                self?.getPortfolioAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    
                    debugPrint("Success to get user portfolio")
                        self?.getPortfolioAPIResult = .onSuccess(response: success)
                    
                    self?.portfolioData = success
                    
                case .failure(let failure):
                        debugPrint("Failed to get user portfolio")
                        self?.getPortfolioAPIResult = .onFailure(error: failure)
                }
            }
        }
    }

    func GetCompaniesLookupsAPI(success:Bool) {
        
        let requestModel = GetCompaniesLookupsRequestModel()
        getCompaniesLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetCompaniesLookups(requestModel: requestModel) {[weak self] result in
                self?.getCompaniesLookupsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getCompaniesLookupsAPIResult = .onSuccess(response: success)
                    
                    UserData.shared.saveCompanies(newCompanies: success)

                case .failure(let failure):
                        self?.getCompaniesLookupsAPIResult = .onFailure(error: failure)
                    debugPrint("Edit watchlist list failure: \(failure)")

                }
            }
        }
    }

}
