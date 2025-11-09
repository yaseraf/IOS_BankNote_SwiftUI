//
//  UIViewController+Extension.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 04/11/2025.
//

import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    /// Returns the top-most view controller in the app window hierarchy
    static func topViewController(base: UIViewController? = nil) -> UIViewController? {
        let baseVC = base ?? UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
        
        if let nav = baseVC as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = baseVC as? UITabBarController {
            return topViewController(base: tab.selectedViewController)
        } else if let presented = baseVC?.presentedViewController {
            return topViewController(base: presented)
        }
        return baseVC
    }
}
