//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by FIT on 10/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol SettingsCoordinatorProtocol: AnyObject,Coordinator {
    func openSettingsScene()
    func openTiersScene()
    func openBadgesScene()
    func openBuyTransactionsScene()
    func openHelpScene()
    func openBankNotesScene()
}
