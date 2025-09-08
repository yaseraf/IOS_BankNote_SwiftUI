//
//  ForgotPasswordViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation

class ForgotPasswordViewModel:ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    
    @Published var forgotType: ForgotDataEnum
    
    init(coordinator: AuthCoordinatorProtocol, forgotType: ForgotDataEnum) {
        self.coordinator = coordinator
        self.forgotType = forgotType
    }
    
    func onBack() {
        coordinator.popViewController()
    }
    
    func onSubmit() {
//        coordinator.openConfirmOtpScene(forgotType: forgotType)
    }
    
    func openCountryPickerScene() {
        coordinator.openCountryPickerScene()
    }
}
