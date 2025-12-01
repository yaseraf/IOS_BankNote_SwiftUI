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
    /// Finds the top-most visible UIViewController
    static func topMostViewController(base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
        
        if let hosting = base as? UIHostingController<AnyView> {
            return hosting
        }
        
        if let nav = base as? UINavigationController {
//            return topMostViewController(base: nav.visibleViewController)
            return nav.visibleViewController
        }
        
        if let tab = base as? UITabBarController {
            return topMostViewController(base: tab.selectedViewController)
        }
        
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }
        
        return nil
    }
}

extension UIApplication {
    static func topVC() -> UIViewController? {
        guard let windowScene = shared.connectedScenes.first as? UIWindowScene,
              let root = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController
        else { return nil }

        var top = root
        while let presented = top.presentedViewController {
            top = presented
        }
        return top
    }
}
