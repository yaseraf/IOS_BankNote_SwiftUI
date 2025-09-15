//
//  LoginInformationViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
class LoginInformationViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    @Published var stepNumber: Int = 2
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        self.stepNumber = stepNumber
    }
}

// MARK: Routing
extension LoginInformationViewModel {
    func openScanIDFrontScene() {
        coordinator.openScanIDFrontScene()
    }
}
