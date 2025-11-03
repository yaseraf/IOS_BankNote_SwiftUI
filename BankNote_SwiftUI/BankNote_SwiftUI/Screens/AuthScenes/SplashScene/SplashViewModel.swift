//
//  SplashViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation

class SplashViewModel: ObservableObject {
    private let coordinator: AppCoordinatorProtocol
    init(coordinator: AppCoordinatorProtocol) {
        self.coordinator = coordinator
    }

}

extension SplashViewModel {
    func openBoardingScene( ) {
//        coordinator.showAuthFlow(startWith: UserDefaultController().isFirstLogin ?? true ? .boarding : .login)
//        SceneDelegate.getAppCoordinator()?.openTermsAndConditionsScene()
    }
    
    func openLoginScene() {
        coordinator.startFlow(startWith: .boarding)
//        SceneDelegate.getAppCoordinator()?.showHomeFlow() // For Testing
    }

    func openHomeScene( ) {
    }
}
