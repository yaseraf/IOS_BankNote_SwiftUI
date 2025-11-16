//
//  AppCoordinatorProtocol.swift
//  mahfazati
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
protocol AppCoordinatorProtocol: AnyObject,Coordinator {
    func startFlow(startWith:AuthStartSceneType)
//    func showAuthFlow(startWith:AuthCoordinator.AuthStartSceneType)
}
