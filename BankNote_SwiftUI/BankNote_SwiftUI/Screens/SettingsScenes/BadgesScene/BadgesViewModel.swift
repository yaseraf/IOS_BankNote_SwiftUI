//
//  BadgesViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class BadgesViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let homeUseCase: HomeUseCaseProtocol
    
    @Published var getTiersAPIResult:APIResultType<GetTiersUIModel>?
    @Published var getBankNotesMainBadgesAPIResult:APIResultType<GetBankNotesMainBadgesUIModel>?
    
    @Published var tiersData: GetTiersUIModel = .initializer()
    @Published var badgesData: GetBankNotesMainBadgesUIModel = .initializer()

    init(coordinator: SettingsCoordinatorProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
    
}

// MARK: Routing
extension BadgesViewModel {
    func popViewController() {
        coordinator.popViewController()
    }

}

// MARK: API Calls
extension BadgesViewModel {
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
                    self?.tiersData = success
                    
                case .failure(let failure):
                        self?.getTiersAPIResult = .onFailure(error: failure)
                    debugPrint("get tiers failed")
                }
            }
        }
    }
    
    func callGetBankNotesMainBadgesAPI(success:Bool) {
        let requestModel = GetBankNotesMainBadgesRequestModel(WebCode: KeyChainController().webCode ?? "")
        
        getBankNotesMainBadgesAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetBankNotesMainBadges(requestModel: requestModel) {[weak self] result in
                self?.getBankNotesMainBadgesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getBankNotesMainBadgesAPIResult = .onSuccess(response: success)
                    debugPrint("get bank notes main badges success")
                    self?.badgesData = success
                    
                case .failure(let failure):
                        self?.getBankNotesMainBadgesAPIResult = .onFailure(error: failure)
                    debugPrint("get bank notes main badges failed")
                }
            }
        }
    }

}
