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

class TradeCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
//        openOrderListScene()
    }

    func restart() {
        start()
    }
}
extension TradeCoordinator:TradeCoordinatorProtocol{

//    func openOrderListScene() {
//        let useCase = GenericUseCase()
//        let viewModel = OrderListViewModel(coordinator: self, useCase: useCase)
//        let view = OrderListScene(viewModel: viewModel)
//        let viewWithCoordinator = view.withThemeEnvironment
//        let viewController = UIHostingController(rootView: viewWithCoordinator)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//    
//    func openTradeScene(stock: OrderListUIModel, typeOfTrade: TypeOfTrade) {
//        let useCase = TradeUseCase()
//        let viewModel = TradeViewModel(coordinator: self, useCase: useCase, selectedStock: stock, typeOfTrade: typeOfTrade)
//        let view = TradeScene(viewModel: viewModel)
//        let viewWithCoordinator = view.withThemeEnvironment
//        let viewController = UIHostingController(rootView: viewWithCoordinator)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
//    
//    func openQuantityCalculatorScene(delegate: QuantityCalculatorDelegate) {
//        let viewModel = QuantityCalculatorViewModel(coordinator: self, delegate: delegate)
//        let view = QuantityCalculatorScene(viewModel: viewModel)
//        let viewWithCoordinator = view.withThemeEnvironment
//        let viewController = UIHostingController(rootView: viewWithCoordinator)
//        viewController.view.backgroundColor = .clear
//        viewController.modalPresentationStyle = .pageSheet
//        viewController.sheetPresentationController?.detents = [.medium()]
//        self.navigationController.topViewController?.present(viewController, animated: true)
//    }
//    
//    func openTradeConfrimationScene(shares: String, price: String, value: String, expiryDate: String, selectedTypeOfTrade: TypeOfTrade) {
//        let viewModel = TradeConfirmationViewModel(coordinator: self, shares: shares, price: price, value: value, expiryDate: expiryDate, selectedTypeOfTrade: selectedTypeOfTrade)
//        let view = TradeConfirmationScene(viewModel: viewModel)
//        let viewWithCoordinator = view.withThemeEnvironment
//        let viewController = UIHostingController(rootView: viewWithCoordinator)
//        viewController.view.backgroundColor = .clear
//        viewController.modalPresentationStyle = .pageSheet
//        viewController.sheetPresentationController?.detents = [.medium()]
//        self.navigationController.topViewController?.present(viewController, animated: true)
//    }
    
    
}
