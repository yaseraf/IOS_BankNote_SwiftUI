//
//  HelpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class HelpViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Routing
extension HelpViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}
