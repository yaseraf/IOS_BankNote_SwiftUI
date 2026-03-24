//
//  HomeViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation
import UIKit
import PaymobSDK

class HomeViewModel: ObservableObject, PaymobSDKDelegate {
    func transactionRejected(message: String) {
        debugPrint("Transaction Rejected home: \(message)")
    }

    func transactionAccepted(transactionDetails: [String : Any]) {
        debugPrint("Transaction Successfull home: \(transactionDetails)")
    }

    func transactionPending() {
        debugPrint("Transaction Pending home")
    }

    
    private let coordinator: HomeCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    private let lookupsUseCase: LookupsUseCaseProtocol
    
    @Published var portfolioData: GetPortfolioUIModel?
    @Published var transactionType: TransactionTypes?
    
    @Published var getUserAccountsAPIResult:APIResultType<[GetUserAccountsUIModel]>?
    @Published var getPortfolioAPIResult:APIResultType<GetPortfolioUIModel>?
    @Published var getPaymobAPIResult:APIResultType<PaymobGetSdkTokenUIModel>?
    @Published var getCompaniesLookupsAPIResult:APIResultType<[GetCompaniesLookupsUIModel]>?

    @Published var viewController: UIViewController?
    
    init(coordinator: HomeCoordinatorProtocol, useCase: HomeUseCaseProtocol, lookupsUseCase: LookupsUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.lookupsUseCase = lookupsUseCase
        
        connectAndSetupSignalR()
        Connection_Hub.shared.notifyOrderDelegate = self
        PaymobViewController.shared.paymob.delegate = self
        Connection_Hub.shared.connectionDelegate = self
        
        UserDefaultController().allSubAccounts = []

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
//        callGetPaymobAPI(success: true)
    }
    
    func openPortfolioScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().openPortfolioScene()
    }
    
    func openStockDetailsScene(symbol: String, marketType: String, custodianID: String, custodianName: String) {
        
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == UserDefaultController().selectedSymbol ?? ""}).first ?? .testUIModel()

        UserDefaultController().selectedSymbol = symbol
        UserDefaultController().selectedSymbolID = selectedStock.symbolID
        UserDefaultController().selectedSymbolType = marketType
        UserDefaultController().selectedCustodian = custodianID
        UserDefaultController().CUSTODYID = custodianID
        UserDefaultController().selectedCustodianName = custodianName
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().openStockDetailsScene(symbol: symbol, marketType: marketType)
    }
    
    func openNotificationsScene() {
        
    }
    
    func openTransactionHistoryScene() {
        coordinator.openTransactionHistoryScene()
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
                    
                    UserDefaultController().allSubAccounts = success
                    
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
                    
                    UserDefaultController().userBalance = success.accountSummaries.balance ?? ""
                    
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
            await lookupsUseCase.GetCompaniesLookups(requestModel: requestModel) {[weak self] result in
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

// MARK: - Delegates
extension HomeViewModel: NotifyOrderDelegate {
    func onNotifyOrder(newOrder: SendOrdersUIModel) {
        if newOrder.StatusCode?.lowercased() == "p" || newOrder.StatusCode?.lowercased() == "s" { // Partially or fully filled
            callGetPortfolioAPI(success: true)
        }
    }
    func onNewOrder(newOrder: OrderListUIModel) {
    }
}

extension HomeViewModel: ConnectionDelegate {
    func onConnect() {
        UserDefaultController.instance.isSignalRConnected = true
    }
    
    func onDisconnect() {
        UserDefaultController.instance.isSignalRConnected = false
    }
}

