//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by FIT on 10/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol TradeCoordinatorProtocol: AnyObject,Coordinator {
    func openTradeScene()
    func openIndexScene()
    func openWatchlistScene()
    func openNewsScene()
}
