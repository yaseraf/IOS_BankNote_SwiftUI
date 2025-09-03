//
//  ChangePasswordViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation

class ChangePasswordViewModel: ObservableObject {
    private var coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func onBack() {
        coordinator.popViewController(animated: true)
    }
    
    func onConfirmChangePassword() {
        coordinator.popMultipleViews(count: 2, animated: true)
    }
}
