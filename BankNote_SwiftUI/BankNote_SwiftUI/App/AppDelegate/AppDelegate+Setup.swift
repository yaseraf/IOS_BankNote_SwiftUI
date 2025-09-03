//
//  AppDelegate+Setup.swift
//  QSC
//
//  Created by FIT on 02/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
extension AppDelegate{

    func setup() {
        AppDelegate.shared = self
        InjectController.shared.setupAll()
        AppUtility.shared.applyDeviceLanguageIfNeeded()
        IQKeyboardManager.shared.isEnabled = false
        
        @Inject var userDefaultController: UserDefaultController?
        if userDefaultController?.appTheme == nil{
            userDefaultController?.appTheme = .system
        }
#if DEBUG
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
#endif
    }

    func connectSignalR() {
        Connection_Hub.shared.setupHubSignalR()
        if !Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.connection?.start()
        }
    }
}
