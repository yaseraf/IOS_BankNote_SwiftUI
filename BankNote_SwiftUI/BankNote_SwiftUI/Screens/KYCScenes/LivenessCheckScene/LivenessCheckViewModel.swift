//
//  LivenessCheckViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
class LivenessCheckViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
}

// MARK: Routing
extension LivenessCheckViewModel {
    func openLivenessScanScene() {
        coordinator.openLivenessScanScene(type: .selfieMode(liveness: true), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)
    }
}
