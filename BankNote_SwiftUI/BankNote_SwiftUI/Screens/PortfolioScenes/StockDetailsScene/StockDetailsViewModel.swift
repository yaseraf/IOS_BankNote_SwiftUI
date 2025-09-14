//
//  StockDetailsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class StockDetailsViewModel: ObservableObject {
    private let coordinator: PortfolioCoordinatorProtocol
    
    init(coordinator: PortfolioCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Routing
extension StockDetailsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func goBack() {
        coordinator.popViewController()
    }
    
    func openOrderEntryScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().openOrderEntryScene()
    }
}
