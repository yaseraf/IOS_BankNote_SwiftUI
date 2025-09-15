//
//  VerifyScanIDFrontViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
class VerifyScanIDFrontViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    @Published var stepNumber:Int = 3
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Routing
extension VerifyScanIDFrontViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openScanIDBackScene() {
        coordinator.openScanIDBackScene()
    }
}
