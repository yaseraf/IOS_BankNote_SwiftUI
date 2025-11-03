//
//  QuestioneerViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
class QuestioneerViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Routing
extension QuestioneerViewModel {
    func openThanksForRegisteringScene() {
        coordinator.openThanksForRegisteringScene()
    }
}
