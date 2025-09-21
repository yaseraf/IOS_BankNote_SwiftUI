//
//  OrderEntryViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation

class OrderEntryViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    
    init(coordinator: TradeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Routing
extension OrderEntryViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openPaymentMethodScene(transactionType: .topUp)
    }
}
