//
//  BankNotesViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI
import PaymobSDK

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
    @Published var CreateBuyBanknotesJVAPIResult:APIResultType<CreateBuyBankNotesJVUIModel>?
    @Published var getRiskManagementAPIResult:APIResultType<GetRiskManagementUIModel>?
    @Published var getPaymobAPIResult:APIResultType<PaymobGetSdkTokenUIModel>?

    @Published var bankNotesData: GetBankNoteUIModel = .initializer()
    @Published var clientBankNotes: String = "0"
    @Published var selectedPrice: String = ""
    @Published var selectedQuantity: String = ""
    
    @Published var viewController: UIViewController?

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
    
    func openTopUpScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openTopUpScene(transactionType: .topUp)
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
    
    func callGetPaymobAPI(success: Bool, amount: String, quantity: String) {
                        
        let requestModel = PaymobGetSdkTokenRequestModel(
            amount: Double((Int(amount) ?? 0) * 100),
            billingData: BillingDataRequestModel(
                apartment: "5",
                building: "1",
                city: "Cairo",
                country: "Egypt",
                email: "test@gmail.com",
                firstName: "Test",
                floor: "3",
                lastName: "Test Last Name",
                phoneNumber: "201221952222",
                postalCode: "12345",
                state: "Cairo",
                street: "Test street"
            ),
            clientID: "-1",
            currency: "EGP",
            itemDescription: "Payment via Paymob",
            itemName: "Payment",
            notificationUrl: "https://trade.rol.com.eg/MobileServices/GeneralWServices/notification",
            quantity: Int(quantity) ?? 0,
            redirectionUrl: "https://trade.rol.com.eg/MobileServices/GeneralWServices/redirect",
            webCode: KeyChainController().webCode ?? ""
        )
        
        getPaymobAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.PaymobGetSdkToken(requestModel: requestModel) {[weak self] result in
                
                self?.getPaymobAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    
                    debugPrint("Success paymob authorize")
                    self?.getPaymobAPIResult = .onSuccess(response: success)
                    
                    PaymobViewController.shared.presentPaymob(vc: self?.viewController, clientSecret: success.clientSecret ?? "")
                    
                case .failure(let failure):
                        debugPrint("Failed paymob authorize")
                        self?.getPaymobAPIResult = .onFailure(error: failure)
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
                    self?.clientBankNotes = success.balance ?? "0"
                    
                case .failure(let failure):
                        self?.getClientBankNotesAPIResult = .onFailure(error: failure)
                    debugPrint("get client bank notes failed")
                }
            }
        }
    }

    func callCreateBuyBankNotesJVAPI(success:Bool, price: String, qty: String) {
        let requestModel = CreateBuyBankNotesJVRequestModel(
            Amount: price,
            BanknotesQTY: qty,
            ClientID: KeyChainController().clientID ?? "",
            MainClientID: KeyChainController().mainClientID ?? "",
            WebCode: KeyChainController().webCode ?? ""
        )
        
        CreateBuyBanknotesJVAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.CreateBuyBankNotesJV(requestModel: requestModel) {[weak self] result in
                self?.CreateBuyBanknotesJVAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.CreateBuyBanknotesJVAPIResult = .onSuccess(response: success)
                    debugPrint("get Create Buy Banknotes JV success")
                    
                case .failure(let failure):
                        self?.CreateBuyBanknotesJVAPIResult = .onFailure(error: failure)
                    debugPrint("get Create Buy Banknotes JV failed")
                }
            }
        }
    }
}
