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

class FavoriteCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
//        openFavoriteScene()
    }

    func restart() {
        start()
    }
}
extension FavoriteCoordinator:FavoriteCoordinatorProtocol{

//    func openFavoriteScene() {
//        let viewModel = FavoriteViewModel(coordinator: self)
//        let view = FavoriteScene(viewModel: viewModel)
//        let viewWithCoordinator = view.withThemeEnvironment
//        let viewController = UIHostingController(rootView: viewWithCoordinator)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }

}
