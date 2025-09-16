//
//  ThanksForRegisteringViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
class ThanksForRegisteringViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            SceneDelegate.getAppCoordinator()?.startFlow(startWith: .boarding)
        }
    }
}

// MARK: Routing
extension ThanksForRegisteringViewModel {
    
}
