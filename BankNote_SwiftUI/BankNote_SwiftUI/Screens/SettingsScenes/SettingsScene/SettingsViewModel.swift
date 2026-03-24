//
//  SettingsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let useCase: SettingsUseCaseProtocol
    private let homeUseCase: HomeUseCaseProtocol
    
    @Published var usersLogOffAPIResult:APIResultType<UsersLogOffUIModel>?
    @Published var getClientBankNotesAPIResult:APIResultType<GetClientBankNotesUIModel>?

    @Published var getTiersAPIResult:APIResultType<GetTiersUIModel>?

    @Published var userTier: GetTiersItemUIModel?

    @Published var clientBankNotes: String = ""
    
    init(coordinator: SettingsCoordinatorProtocol, useCase: SettingsUseCaseProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.homeUseCase = homeUseCase
    }
    
    
}

// MARK: Routing
extension SettingsViewModel {
    func openTiersScene() {
        coordinator.openTiersScene()
    }
    
    func openBadgesScene() {
        coordinator.openBadgesScene()
    }
    
    func openBuyTransactionsScene() {
        coordinator.openBuyTransactionsScene()
    }
    
    func openHelpScene() {
        coordinator.openHelpScene()
    }
    
    func openBankNotesScene() {
        coordinator.openBankNotesScene()
    }
    
    func openStatementsScene() {
        coordinator.openStatementsScene()
    }

    func openInvoicesScene() {
        coordinator.openInvoicesScene()
    }

}

// MARK: API Calls
extension SettingsViewModel {
    func UsersLogOffAPI(success:Bool) {
        let requestModel = UsersLogOffRequestModel()
        usersLogOffAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.UsersLogOff(requestModel: requestModel) {[weak self] result in
                self?.usersLogOffAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.usersLogOffAPIResult = .onSuccess(response: success)
                    UserDefaultController().isLoggedIn = false
                    UserDefaultController().selectedUserAccount = nil
                    debugPrint("Logoff success")
                    
                    self?.disconnectSignalR()
                    
                    self?.signOut()
                    
                case .failure(let failure):
                        self?.usersLogOffAPIResult = .onFailure(error: failure)
                    debugPrint("Logoff fail")
                }
            }
        }
    }
    
    func callGetTiersAPI(success:Bool) {
        let requestModel = GetTiersRequestModel(WebCode: KeyChainController().webCode ?? "")
        
        getTiersAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetTiers(requestModel: requestModel) {[weak self] result in
                self?.getTiersAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getTiersAPIResult = .onSuccess(response: success)
                    debugPrint("get tiers success")

                    if let userTier = success.data?.first(where: {$0.code == UserDefaultController().tierCode}) {
                        self?.userTier = userTier
                    }
                    
                case .failure(let failure):
                        self?.getTiersAPIResult = .onFailure(error: failure)
                    debugPrint("get tiers failed")
                }
            }
        }
    }

    func callGetClientBankNotesAPI(success:Bool) {
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

// MARK: Functions
extension SettingsViewModel {
    private func disconnectSignalR() {
        if Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.connection?.stop()
        }
    }
    
    func signOut(){
        UserDefaultController().isAutoLogin = false
        coordinator.dismiss(complete: {
            SceneDelegate.getAppCoordinator()?.logout()
        })
    }
}
