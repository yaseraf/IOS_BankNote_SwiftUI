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
        let homeUseCase = HomeUseCase()
        let viewModel = SettingsViewModel(coordinator: self, useCase: useCase, homeUseCase: homeUseCase)
        let view = SettingsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openTiersScene() {
        let homeUseCase = HomeUseCase()
        let viewModel = TiersViewModel(coordinator: self, homeUseCase: homeUseCase)
        let view = TiersScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openBadgesScene() {
        let homeUseCase = HomeUseCase()
        let viewModel = BadgesViewModel(coordinator: self, homeUseCase: homeUseCase)
        let view = BadgesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openBuyTransactionsScene() {
        let homeUseCase = HomeUseCase()
        let viewModel = BuyTransactionsViewModel(coordinator: self, homeUseCase: homeUseCase)
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
        let homeUseCase = HomeUseCase()
        let viewModel = BankNotesViewModel(coordinator: self, homeUseCase: homeUseCase)
        let view = BankNotesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openStatementsScene() {
        let homeUseCase = HomeUseCase()
        let viewModel = StatementsViewModel(coordinator: self, useCase: homeUseCase)
        let view = StatementsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openInvoicesScene() {
        let homeUseCase = HomeUseCase()
        let viewModel = InvoicesViewModel(coordinator: self, useCase: homeUseCase)
        let view = InvoicesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    
}
