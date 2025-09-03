//
//  AppEnvironmentController.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum AppEnvironment {
    case debug
    case testFlight
    case appStore
}


struct AppEnvironmentController{

    static var appEnvironment: AppEnvironment {
        let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"

#if DEBUG
        return .debug // .debug
#else
        if isTestFlight {
            return .testFlight
        } else {
            return .appStore
        }
#endif
    }

    static var currentNetworkConfiguration: NetworkConfiguration = {
        if appEnvironment == .testFlight {
            return .development
        }
        else if appEnvironment == .appStore {
            return .production
        }
        else{
            return .development
        }
    }()
}
