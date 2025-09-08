//
//  PaymentMethodViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
class PaymentMethodViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openSuccessTopUpScene() {
        
    }
}
