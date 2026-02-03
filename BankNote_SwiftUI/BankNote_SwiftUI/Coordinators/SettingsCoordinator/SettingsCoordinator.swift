//
//  HomeCoorindator.swift
//  mahfazati
//
//  Created by FIT on 10/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode

class SettingsCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        self.navigationController.viewControllers = []
        AppUtility.shared.screenTransition(navigationController: navigationController, animationOptions: .transitionCrossDissolve, duration: 0.3, animated: false)

        openSettingsScene()
    }

    func restart() {
        start()
    }
}
extension SettingsCoordinator:SettingsCoordinatorProtocol{

    func openSettingsScene() {
        let useCase = SettingsUseCase()
        let viewModel = SettingsViewModel(coordinator: self, useCase: useCase)
        let view = SettingsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openTiersScene() {
        let viewModel = TiersViewModel(coordinator: self)
        let view = TiersScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openBadgesScene() {
        let viewModel = BadgesViewModel(coordinator: self)
        let view = BadgesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openBuyTransactionsScene() {
        let viewModel = BuyTransactionsViewModel(coordinator: self)
        let view = BuyTransactionsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openHelpScene() {
        let viewModel = HelpViewModel(coordinator: self)
        let view = HelpScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openBankNotesScene() {
        let viewModel = BankNotesViewModel(coordinator: self)
        let view = BankNotesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
