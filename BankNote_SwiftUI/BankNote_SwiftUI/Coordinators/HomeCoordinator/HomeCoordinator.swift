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

class HomeCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
//        openHomeScene()
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
    
    func getFavoriteCoordinator() -> FavoriteCoordinator {
        let  coordinator:FavoriteCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: FavoriteCoordinator.self) as? FavoriteCoordinator {
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


}
