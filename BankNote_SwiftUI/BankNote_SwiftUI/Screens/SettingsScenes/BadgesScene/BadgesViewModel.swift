//
//  BadgesViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class BadgesViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}

// MARK: Routing
extension BadgesViewModel {
    func popViewController() {
        coordinator.popViewController()
    }

}
