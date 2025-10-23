//
//  ScanIDFrontViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
class ScanIDBackViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    @Published var stepNumber: Int = 0
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension ScanIDBackViewModel {
    func openVerifyScanIDFrontScene() {
//        coordinator.openVerifyScanIDBackScene()
    }
}
