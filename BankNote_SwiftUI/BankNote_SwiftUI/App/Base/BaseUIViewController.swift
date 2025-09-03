//
//  BaseUIViewController.swift
//  QSC
//
//  Created by FIT on 06/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

import Foundation
import UIKit
class BaseUIViewController: UIViewController,UIAdaptivePresentationControllerDelegate{
        public func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
            if presentationController.presentedViewController.modalPresentationStyle == .pageSheet {
                // Set dark background when presented as a form sheet
                presentationController.presentedViewController.view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            } else {
                // Default to clear or other color
                presentationController.presentedViewController.view.backgroundColor = UIColor.clear
            }
        }
  
}
