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

class TradeCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
        openTradeScene()
    }

    func restart() {
        start()
    }
}
extension TradeCoordinator:TradeCoordinatorProtocol{
    
    func openTradeScene() {
        let useCase = TradeUseCase()
        let lookupsUseCase = LookupsUseCase()
        let viewModel = TradeViewModel(coordinator: self, useCase: useCase, lookupsUseCase: lookupsUseCase)
        let view = TradeScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openIndexScene() {
        let useCase = TradeUseCase()
        let viewModel = IndexViewModel(coordinator: self, useCase: useCase)
        let view = IndexScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openWatchlistScene() {
        let useCase = TradeUseCase()
        let viewModel = WatchlistViewModel(coordinator: self, useCase: useCase)
        let view = WatchlistScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openNewsScene() {
        let useCase = TradeUseCase()
        let viewModel = NewsViewModel(coordinator: self, useCase: useCase)
        let view = NewsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
