//
//  HomeCoorindator.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode

class PortfolioCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
        openPortfolioScene()
    }

    func restart() {
        start()
    }
}
extension PortfolioCoordinator:PortfolioCoordinatorProtocol{

    func openPortfolioScene() {
        let useCase = HomeUseCase()
        let viewModel = PortfolioViewModel(coordinator: self, useCase: useCase)
        let view = PortfolioScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openStockDetailsScene(symbol: String, marketType: String) {
        let useCase = HomeUseCase()
        let viewModel = StockDetailsViewModel(coordinator: self, useCase: useCase, symbol: symbol, marketType: marketType)
        let view = StockDetailsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
