//
//  VerifySignUpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
class VerifySignUpViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    @Published var verificationType: VerificationType
    @Published var phone: String
    @Published var email: String
    
    init(coordinator: AuthCoordinatorProtocol, verificationType: VerificationType, phone: String, email: String) {
        self.coordinator = coordinator
        self.verificationType = verificationType
        self.phone = phone
        self.email = email
    }
}

// MARK: Routing
extension VerifySignUpViewModel {
    func openSignUpScene() {
        coordinator.openSignUpScene(verificationType: .email)
    }
    
    func openChooseNationalityScene() {
        coordinator.openChooseNationalityScene()
    }
}
