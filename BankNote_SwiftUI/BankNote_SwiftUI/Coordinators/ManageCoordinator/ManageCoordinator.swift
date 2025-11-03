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

class ManageCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController

    init( navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.navigationController.viewControllers = []
//        openManageScene()
    }

    func restart() {
        start()
    }
}
extension ManageCoordinator:ManageCoordinatorProtocol{

    
}
