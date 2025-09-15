//
//  SignUpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation

class SignUpViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    @Published var verificationType: VerificationType
    @Published var phone: String = ""
    @Published var email: String = ""
    
    init(coordinator: AuthCoordinatorProtocol, verificationType: VerificationType) {
        self.coordinator = coordinator
        
        self.verificationType = verificationType
    }
    
    
}

extension SignUpViewModel {
    func openVerifySignUpScene() {
        coordinator.openVerifySignUpScene(verificationType: verificationType, phone: phone, email: email)
    }
}
