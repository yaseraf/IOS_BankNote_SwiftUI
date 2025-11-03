//
//  TiersViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class TiersViewModel: ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
}
