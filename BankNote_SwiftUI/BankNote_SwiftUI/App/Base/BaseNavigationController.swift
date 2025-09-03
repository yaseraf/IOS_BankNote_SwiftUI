//
//  BaseNavigationController.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }

    func checkViewControllerExistInNavigationStack(scene: any BaseSceneType.Type)->UIViewController? {
        return self.viewControllers.first(where: { $0.title == "ProfileRequestScene" })

    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .pad ?  topViewController?.supportedInterfaceOrientations ?? .all : .portrait
    }

    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? true
    }
}

extension BaseNavigationController:UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Return false to disable the swipe-back gesture
        if UserDefaultController().isLoggedIn ?? false {
            return false
        }
        return true
    }
}
