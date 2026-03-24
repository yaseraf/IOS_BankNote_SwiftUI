//
//  TopUpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import UIKit
import PaymobSDK

class TopUpViewModel: ObservableObject, PaymobSDKDelegate {
    func transactionRejected(message: String) {
        debugPrint("Transaction Rejected top up: \(message)")
        coordinator.popViewController()
    }

    func transactionAccepted(transactionDetails: [String : Any]) {
        debugPrint("Transaction Successfull top up: \(transactionDetails)")
    }

    func transactionPending() {
        debugPrint("Transaction Pending top up")
    }
    
    private let coordinator: HomeCoordinatorProtocol
    private let homeUseCase: HomeUseCaseProtocol
    
    private let paymobApiKey = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBNE56WXlNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5XcnFoSWpJalByZFpaeU1KY3dOdjJuMWdwbU9SS1F4SXJCaVcyZ0x0UWdHNDV5eGJBd200UEtFbll4TmlxY2tleDVXamU1dUo5NUNEQ1FZa0xyQWFmQQ=="
    
    @Published var getPaymobAPIResult:APIResultType<PaymobGetSdkTokenUIModel>?

    @Published var transactionTypes: TransactionTypes?
    
    @Published var paymobData: PaymobGetSdkTokenUIModel = .initializer()
    @Published var viewController: UIViewController?

    init(coordinator: HomeCoordinatorProtocol, transactionTypes: TransactionTypes?, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.homeUseCase = homeUseCase
        
        self.transactionTypes = transactionTypes
        
        PaymobViewController.shared.paymob.delegate = self
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        coordinator.openPaymentMethodScene(transactionType: transactionTypes ?? .topUp)
    }
}

// MARK: API Calls
extension TopUpViewModel {
    func callGetPaymobAPI(success: Bool, amount: Double) {
                        
        let requestModel = PaymobGetSdkTokenRequestModel(
            amount: amount * 100,
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
            quantity: 1,
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
}
