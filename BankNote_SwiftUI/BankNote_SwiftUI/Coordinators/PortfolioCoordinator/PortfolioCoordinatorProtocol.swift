//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol PortfolioCoordinatorProtocol: AnyObject,Coordinator {
    func openPortfolioScene()
    func openStockDetailsScene()
}
