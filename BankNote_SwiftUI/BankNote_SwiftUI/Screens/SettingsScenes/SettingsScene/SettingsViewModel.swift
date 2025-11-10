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
    
    @Published var usersLogOffAPIResult:APIResultType<UsersLogOffUIModel>?

    init(coordinator: SettingsCoordinatorProtocol, useCase: SettingsUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
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
