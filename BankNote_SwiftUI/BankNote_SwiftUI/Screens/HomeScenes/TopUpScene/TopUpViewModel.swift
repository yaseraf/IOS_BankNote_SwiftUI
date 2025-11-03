//
//  TopUpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation

class TopUpViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var transactionTypes: TransactionTypes?
    
    init(coordinator: HomeCoordinatorProtocol, transactionTypes: TransactionTypes?) {
        self.coordinator = coordinator
        
        self.transactionTypes = transactionTypes
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        coordinator.openPaymentMethodScene(transactionType: transactionTypes ?? .topUp)
    }
}
