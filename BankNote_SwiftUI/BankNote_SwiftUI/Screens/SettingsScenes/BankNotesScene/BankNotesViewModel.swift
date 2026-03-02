//
//  BankNotesViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI

// The main data model for a row item.
struct RowItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let color: Color
    let icon: String?
}

class BankNotesViewModel:ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    private let homeUseCase: HomeUseCaseProtocol
    
    @Published var getBankNotesAPIResult:APIResultType<GetBankNoteUIModel>?
    @Published var getClientBankNotesAPIResult:APIResultType<GetClientBankNotesUIModel>?

    @Published var bankNotesData: GetBankNoteUIModel = .initializer()
    @Published var clientBankNotes: String = ""
    
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
extension BankNotesViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openPaymentMethodScene(transactionType: .topUp)
    }
}

// MARK: API Calls
extension BankNotesViewModel {
    func callGetBankNotesAPI(success:Bool) {
        let requestModel = GetBankNoteRequestModel(WebCode: KeyChainController().webCode ?? "")
        
        getBankNotesAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetBankNote(requestModel: requestModel) {[weak self] result in
                self?.getBankNotesAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getBankNotesAPIResult = .onSuccess(response: success)
                    debugPrint("get bank notes success")
                    self?.bankNotesData = success
                    
                case .failure(let failure):
                        self?.getBankNotesAPIResult = .onFailure(error: failure)
                    debugPrint("get bank notes failed")
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
