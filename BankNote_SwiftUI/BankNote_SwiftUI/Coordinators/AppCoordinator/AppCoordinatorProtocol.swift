//
//  AppCoordinatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 22/07/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
protocol AppCoordinatorProtocol: AnyObject,Coordinator {
    func startFlow(startWith:AuthCoordinator.AuthStartSceneType)
//    func showAuthFlow(startWith:AuthCoordinator.AuthStartSceneType)
}
