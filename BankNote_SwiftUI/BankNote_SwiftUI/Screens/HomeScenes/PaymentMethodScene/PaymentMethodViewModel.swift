//
//  PaymentMethodViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
class PaymentMethodViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var transactionType: TransactionTypes?
    
    init(coordinator: HomeCoordinatorProtocol, transactionType: TransactionTypes) {
        self.coordinator = coordinator
        
        self.transactionType = transactionType
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openTransactionSuccessfulScreen() {
        coordinator.openTransactionSuccessfulScreen(transactionType: transactionType ?? .topUp)
    }
}
