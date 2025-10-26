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

class OrdersCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
        openOrdersScene()
    }

    func restart() {
        start()
    }
}
extension OrdersCoordinator:OrdersCoordinatorProtocol {
    
    func openOrdersScene() {
        let lookupsUseCase = LookupsUseCase()
        let viewModel = OrdersViewModel(coordinator: self, lookupsUseCase:  lookupsUseCase)
        let view = OrdersScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openOrderEntryScene(orderDetails: OrderListUIModel, placeOrderType: PlaceOrderType, isEditOrder: Bool) {
        let useCase = HomeUseCase()
        let lookupsUseCase = LookupsUseCase()
        let viewModel = OrderEntryViewModel(coordinator: self, useCase: useCase, lookupsUseCase: lookupsUseCase, orderDetails: orderDetails, placeOrderType: placeOrderType, isEditOrder: isEditOrder)
        let view = OrderEntryScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openOrderDetailsScene(orderPreview: OrderListUIModel, riskManagementData: GetRiskManagementUIModel, isEditOrder: Bool) {
        let useCase = HomeUseCase()
        let viewModel = OrderDetailsViewModel(coordinator: self, useCase: useCase, orderPreview: orderPreview, riskManagementData: riskManagementData, isEditOrder: isEditOrder)
        let view = OrderDetailsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openOrderEditScene(orderDetails: OrderListUIModel, delegate: OrderEditDelegate) {
        let viewModel = OrderEditViewModel(coordinator: self, orderDetails: orderDetails, delegate: delegate)
        let view = OrderEditScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }

}
