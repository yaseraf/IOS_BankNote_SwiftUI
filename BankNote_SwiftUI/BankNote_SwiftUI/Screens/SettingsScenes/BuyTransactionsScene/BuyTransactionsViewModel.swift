//
//  BankNotesViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI

class BuyTransactionsViewModel:ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let homeUseCase: HomeUseCaseProtocol
    
    @Published var getTransactionsPackagesAPIResult:APIResultType<GetTransactionsPackagesUIModel>?
    @Published var getClientTransactionsPackagesAPIResult:APIResultType<GetClientTransactionsPackagesUIModel>?
    @Published var getClientBankNotesAPIResult:APIResultType<GetClientBankNotesUIModel>?
    @Published var updateBankNotesTransQtyAPIResult:APIResultType<UpdateBankNotesTransQTYUIModel>?
    
    @Published var transactionsPackagesData: GetTransactionsPackagesUIModel = .initializer()
    
    @Published var clientTransactions: String = "0"
    @Published var clientBankNotes: String = "0"
    
    @Published var topUpItems: [RowItem] = [
        RowItem(title: "100 EGP", value: "1000 BN", color: .purple, icon: nil),
        RowItem(title: "150 EGP", value: "1500 BN", color: .purple, icon: nil),
        RowItem(title: "200 EGP", value: "2000 BN", color: .purple, icon: nil),
        RowItem(title: "250 EGP", value: "2500 BN", color: .purple, icon: nil),
        RowItem(title: "300 EGP", value: "3000 BN", color: .purple, icon: nil),
    ]
    
    @Published var rewardsItems: [RowItem] = [
        RowItem(title: "1 Month Spotify", value: "1000 BN", color: Color("SpotifyGreen"), icon: "play.circle"),
        RowItem(title: "25% OFF Netflix", value: "1500 BN", color: Color("NetflixRed"), icon: "play.rectangle"),
    ]
    
    init(coordinator: SettingsCoordinatorProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
}

// MARK: Routing
extension BuyTransactionsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openPaymentMethodScene(transactionType: .topUp)
    }
    
    func openBankNotesScene() {
        coordinator.openBankNotesScene()
    }
}

// MARK: Functions
extension BuyTransactionsViewModel {
    func onPurchaseTransaction(quantity: String) {
        callUpdateBankNotesTransQTYAPI(success: true, quantity: quantity)
    }
}

// MARK: API Calls
extension BuyTransactionsViewModel {
    func callGetTransactionsPackagesAPI(success:Bool) {
        let requestModel = GetTransactionsPackagesRequestModel(WebCode: KeyChainController().webCode ?? "")
        
        getTransactionsPackagesAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetTransactionsPackages(requestModel: requestModel) {[weak self] result in
                self?.getTransactionsPackagesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getTransactionsPackagesAPIResult = .onSuccess(response: success)
                    debugPrint("get transactions packages success")
                    self?.transactionsPackagesData = success
                    
                case .failure(let failure):
                        self?.getTransactionsPackagesAPIResult = .onFailure(error: failure)
                    debugPrint("get transactions packages failed")
                }
            }
        }
    }
    
    func callUpdateBankNotesTransQTYAPI(success:Bool, quantity: String) {
        let requestModel = UpdateBankNotesTransQTYRequestModel(
            ClientID: "-1",
            DOC_NO: "", // Empty
            MainClientID: KeyChainController().mainClientID ?? "",
            PORDER_ID: "", // Empty
            QTY: quantity,
            Source: "T", // B Bank notes / T Transactions
            TRANSTYPE: "A", // A Add / U Used
            WebCode: KeyChainController().webCode ?? ""
        )
        
        updateBankNotesTransQtyAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.UpdateBankNotesTransQTY(requestModel: requestModel) {[weak self] result in
                self?.updateBankNotesTransQtyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.updateBankNotesTransQtyAPIResult = .onSuccess(response: success)
                    debugPrint("update BankNotesTransQty success")
                    
                    self?.coordinator.popViewController()
                    
                case .failure(let failure):
                        self?.updateBankNotesTransQtyAPIResult = .onFailure(error: failure)
                    debugPrint("update BankNotesTransQty failed")
                }
            }
        }
    }
    
    func callGetClientTransactionsPackagesAPI(success:Bool) {
//        let requestModel = GetClientTransactionsPackagesRequestModel(ClientID: KeyChainController().clientID ?? "", MainClientID: KeyChainController().mainClientID ?? "", WebCode: KeyChainController().webCode ?? "")
        let requestModel = GetClientTransactionsPackagesRequestModel(ClientID: "-1", MainClientID: KeyChainController().mainClientID ?? "", WebCode: KeyChainController().webCode ?? "")
        
        getClientTransactionsPackagesAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetClientTransActionsPackages(requestModel: requestModel) {[weak self] result in
                self?.getClientTransactionsPackagesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getClientTransactionsPackagesAPIResult = .onSuccess(response: success)
                    debugPrint("get client transactions packages success")
                    self?.clientTransactions = success.balance ?? "0"
                    
                case .failure(let failure):
                        self?.getClientTransactionsPackagesAPIResult = .onFailure(error: failure)
                    debugPrint("get client transactions packages failed")
                }
            }
        }
    }
    
    func callGetClientBankNotesAPI(success:Bool) {
//        let requestModel = GetClientBankNotesRequestModel(ClientID: KeyChainController().clientID ?? "", MainClientID: KeyChainController().mainClientID ?? "", WebCode: KeyChainController().webCode ?? "")
        let requestModel = GetClientBankNotesRequestModel(ClientID: "-1", MainClientID: KeyChainController().mainClientID ?? "", WebCode: KeyChainController().webCode ?? "")
        
        getClientBankNotesAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetClientBankNotes(requestModel: requestModel) {[weak self] result in
                self?.getClientBankNotesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getClientBankNotesAPIResult = .onSuccess(response: success)
                    debugPrint("get client bank notes success")
                    self?.clientBankNotes = success.balance ?? ""
                    
                case .failure(let failure):
                        self?.getClientBankNotesAPIResult = .onFailure(error: failure)
                    debugPrint("get client bank notes failed")
                }
            }
        }
    }

}
