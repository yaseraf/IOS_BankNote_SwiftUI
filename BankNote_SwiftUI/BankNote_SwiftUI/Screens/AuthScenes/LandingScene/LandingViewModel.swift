//
//  LandingViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import UIKit

class LandingViewModel:ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        
//        for family in UIFont.familyNames {
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
        
    }
    
    func openLoginScene() {
        SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
    }
    
    func openForgotPasswordScene() {
        coordinator.openForgotPasswordScene(forgotType: .forgotPassword)
    }
    
    func openHomeScene() {
        AppUtility.shared.updateAppLanguage(language: .english)
        SceneDelegate.getAppCoordinator()?.showHomeFlow()
    }
}

// MARK: Routing
extension LandingViewModel {
    func openSignUpScene() {
        coordinator.openSignUpScene(verificationType: .phone)
    }
}
