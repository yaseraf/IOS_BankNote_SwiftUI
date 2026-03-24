//
//  TiersViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class TiersViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let homeUseCase: HomeUseCaseProtocol

    @Published var getTiersAPIResult:APIResultType<GetTiersUIModel>?
    @Published var updateBankNotesTransQtyAPIResult:APIResultType<UpdateBankNotesTransQTYUIModel>?
    @Published var getClientBankNotesAPIResult:APIResultType<GetClientBankNotesUIModel>?
    @Published var updateTiersCodeAPIResult:APIResultType<UpdateTiersCodeUIModel>?
    
    @Published var clientBankNotes: String = ""
    @Published var showInsufficientFunds: Bool = false
    @Published var tiersData: GetTiersUIModel = .initializer()
    @Published var tiers: [Tier] = []

    init(coordinator: SettingsCoordinatorProtocol, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
    }
}

// MARK: Routing
extension TiersViewModel {
    func popViewController() {
        coordinator.popViewController()
    }

    func openBankNotesScene() {
        
        popViewController()
        
        coordinator.openBankNotesScene()
    }
}

// MARK: Functions
extension TiersViewModel {
    func BuyTier(qty: String, tiersCode: String) {
        callUpdateBankNotesTransQTYAPI(success: true, quantity: qty, tiersCode: tiersCode)
    }
}

// MARK: API Calls
extension TiersViewModel {
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
                    
                    for item in self?.tiersData.data ?? [] {
                        self?.tiers.append(
                            Tier(
                                nameKey: (AppUtility.shared.isRTL ? item.arabicDescription : item.englishDescription) ?? "",
                                price: item.banknotesQty ?? "",
                                imageName: "ic_rookie",
                                tierCode: item.code ?? "",
                                descriptionKeys: [],
                                howToBecomeKeys: [],
                                benefitKeys: [item.notes ?? ""]
                            )
                        )
                    }

                    
                case .failure(let failure):
                        self?.getTiersAPIResult = .onFailure(error: failure)
                    debugPrint("get tiers failed")
                }
            }
        }
    }
    
    func callUpdateBankNotesTransQTYAPI(success:Bool, quantity: String, tiersCode: String) {
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
                    
                    self?.UpdateTiersCodeAPI(success: true, tiersCode: tiersCode)
                    
                case .failure(let failure):
                        self?.updateBankNotesTransQtyAPIResult = .onFailure(error: failure)
                    debugPrint("update BankNotesTransQty failed")
                }
            }
        }
    }

    func UpdateTiersCodeAPI(success: Bool, tiersCode: String) {
        let requestModel = UpdateTiersCodeRequestModel(tiersCode: tiersCode, webCode: KeyChainController().webCode ?? "")
        
        updateTiersCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.UpdateTiersCode(requestModel: requestModel) {[weak self] result in
                self?.updateTiersCodeAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.updateTiersCodeAPIResult = .onSuccess(response: success)
                    debugPrint("update tiers code success")
                    
                    self?.coordinator.popViewController()

                case .failure(let failure):
                        self?.updateTiersCodeAPIResult = .onFailure(error: failure)
                    debugPrint("update tiers code failed")
                }
            }
        }
    }

}
