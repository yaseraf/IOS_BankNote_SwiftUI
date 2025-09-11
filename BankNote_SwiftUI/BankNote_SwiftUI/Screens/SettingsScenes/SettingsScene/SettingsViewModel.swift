//
//  SettingsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
}

// MARK: Routing
extension SettingsViewModel {
    func openTiersScene() {
        coordinator.openTiersScene()
    }
    
    func openBadgesScene() {
        coordinator.openBadgesScene()
    }
    
    func openHelpScene() {
        coordinator.openHelpScene()
    }
}
