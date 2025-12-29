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

class HomeCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
        openHomeScene()
    }

    func restart() {
        start()
    }
    
    func getHomeCoordinator() -> HomeCoordinator {
        let  coordinator:HomeCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: HomeCoordinator.self) as? HomeCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getAuthCoordinator(startViewType: AuthStartSceneType) -> AuthCoordinator {
        let coordinator:AuthCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: AuthCoordinator.self) as? AuthCoordinator {
            coordinator = childCoordinator
        } else {
            coordinator = .init(navigationController: navigationController, startViewType: startViewType)
            childCoordinator.append(coordinator)
            
        }
      return coordinator
    }

    
    func getPortfolioCoordinator() -> PortfolioCoordinator {
        let  coordinator:PortfolioCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: PortfolioCoordinator.self) as? PortfolioCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
//    func getManageCoordinator() -> ManageCoordinator {
//        let  coordinator:ManageCoordinator
//        if let  childCoordinator = self.getChildCoordinator(coordinator: ManageCoordinator.self) as? ManageCoordinator {
//            coordinator = childCoordinator
//        }else{
//            coordinator =  .init(navigationController: navigationController)
//            childCoordinator.append(coordinator)
//        }
//      return coordinator
//    }
    
    func getTradeCoordinator() -> TradeCoordinator {
        let  coordinator:TradeCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: TradeCoordinator.self) as? TradeCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getOrdersCoordinator() -> OrdersCoordinator {
        let  coordinator:OrdersCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: OrdersCoordinator.self) as? OrdersCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
    
    func getSettingsCoordinator() -> SettingsCoordinator {
        let  coordinator:SettingsCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: SettingsCoordinator.self) as? SettingsCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }
        
    func getGenericCoordinator() -> GenericCoordinator {
        let  coordinator:GenericCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: GenericCoordinator.self) as? GenericCoordinator {
            coordinator = childCoordinator
        }else{
            coordinator =  .init(navigationController: navigationController)
            childCoordinator.append(coordinator)
        }
      return coordinator
    }

}
extension HomeCoordinator:HomeCoordinatorProtocol{

    func openHomeScene() {
        let useCase = HomeUseCase()
        let lookupsUseCase = LookupsUseCase()
        let viewModel = HomeViewModel(coordinator: self, useCase: useCase, lookupsUseCase: lookupsUseCase)
        let view = HomeScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTopUpScene(transactionType: TransactionTypes) {
        let viewModel = TopUpViewModel(coordinator: self, transactionTypes: transactionType)
        let view = TopUpScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openPaymentMethodScene(transactionType: TransactionTypes) {
        let viewModel = PaymentMethodViewModel(coordinator: self, transactionType: transactionType)
        let view = PaymentMethodScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTransactionSuccessfulScreen(transactionType: TransactionTypes) {
        let viewModel = TransactionSuccessfulViewModel(coordinator: self, transactionType: transactionType)
        let view = TransactionSuccessfulScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

}
