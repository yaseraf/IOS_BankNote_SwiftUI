//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by FIT on 10/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol PortfolioCoordinatorProtocol: AnyObject,Coordinator {
    func openPortfolioScene()
    func openStockDetailsScene(symbol:String, marketType: String)
}
