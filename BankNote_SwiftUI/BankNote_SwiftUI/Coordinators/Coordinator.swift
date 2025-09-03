//
//  Coordinator.swift
//  mahfazati
//
//  Created by Mohammmed on 22/07/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
protocol Coordinator: AnyObject {
    var navigationController: BaseNavigationController { get set }
    var childCoordinator: [Coordinator] { get set }
    func start()
}

extension Coordinator {
   

    func goBack(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func removeFromChildCoordinator(child: Coordinator) {
        for(index, coordinator) in childCoordinator.enumerated() {
            if coordinator === child {
                childCoordinator.remove(at: index)
                break
            }
        }
    }

    func dismiss(animated: Bool = true) {
        SceneDelegate.getAppCoordinator()?.topViewController()?.dismiss(animated: animated)
//            navigationController.dismiss(animated: true)
    }

    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popMultipleViews(count:Int, animated: Bool = true) {
        let stack = navigationController.viewControllers
        guard stack.count > count else { return }
        
        let targetView = stack[stack.count - count - 1]
        
        navigationController.popToViewController(targetView, animated: animated)
    }

    func popViewControllerToScene(animated: Bool = true,scene: any BaseSceneType.Type) {
        if let vc = self.navigationController.checkViewControllerExistInNavigationStack(scene: scene){
            navigationController.popToViewController(vc, animated: animated)
        }
    }

    func dismiss(animated: Bool = true, complete: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: complete)
    }

    
}

extension Coordinator {

    func getChildCoordinator(coordinator:Coordinator.Type)->Coordinator?{

        return childCoordinator.filter({
            let childName = String(describing: $0).split(separator: ".").last ?? ""
           return childName == String(describing: coordinator)

        }).first
    }

    func getChildCoordinatorIndex(coordinator:Coordinator.Type)->Int?{
        return childCoordinator.firstIndex(where: {
            let childName = String(describing: $0).split(separator: ".").last ?? ""
           return childName == String(describing: coordinator)
        })

    }

}
