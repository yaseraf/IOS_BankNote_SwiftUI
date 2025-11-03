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

class GenericCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
//        openSelectSharesScene()
    }

    func restart() {
        start()
    }
}
extension GenericCoordinator:GenericCoordinatorProtocol{

    func openSelectSharesScene(delegate: SelectSharesDelegate) {
        let viewModel = SelectSharesViewModel(coordinator: self, delegate: delegate)
        let view = SelectSharesScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.large()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openSelectPortfolioScene(delegate: SelectPortfolioDelegate, selectedUser: UserUIModel?) {
        let viewModel = SelectPortfolioViewModel(coordinator: self, delegate: delegate, selectedUser: selectedUser)
        let view = SelectPortfolioScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openSelectBankScene(delegate: SelectBankDelegate, selectedBank: BankUIModel?) {
        let viewModel = SelectBankViewModel(coordinator: self, delegate: delegate, selectedBank: selectedBank)
        let view = SelectBankScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }

    func openCancelConfirmationScene(transactionType: TransactionTypes) {
        let viewModel = CancelConfirmationViewModel(coordinator: self, transactionType: transactionType)
        let view = CancelConfirmationScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openRangeCalendarScene(delegate: RangeCalendarDelegate, title: String?, isMultiSelect: Bool?) {
        let viewModel = RangeCalendarViewModel(coordinator: self, delegate: delegate, title: title, isMultiSelect: isMultiSelect)
        let view = RangeCalendarScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [isMultiSelect ?? false ? .large() : .medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openAlertsScene() {
        let viewModel = AlertsViewModel(coordinator: self)
        let view = AlertsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openAddAlertScene() {
        let viewModel = AddAlertViewModel(coordinator: self)
        let view = AddAlertScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openSelectPriceFactorScene(delegate: SelectPriceFactorDelegate) {
        let viewModel = SelectPriceFactorViewModel(coordinator: self, delegate: delegate)
        let view = SelectPriceFactorScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }


}
