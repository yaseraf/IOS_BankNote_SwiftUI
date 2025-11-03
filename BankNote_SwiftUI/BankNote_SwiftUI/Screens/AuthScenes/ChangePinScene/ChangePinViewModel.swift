//
//  ChangePinViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation

class ChangePinViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func onBack() {
        coordinator.popViewController()
    }
    
    func onCreatePin() {
        coordinator.popMultipleViews(count: 2, animated: true)
    }
}
