//
//  ConnectionDelegate.swift
//  QSC
//
//  Created by FIT on 02/03/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

protocol ConnectionDelegate{
    func onConnect()
    func onDisconnect()
    func onSendExchangeMarketObject(data: [GetExchangeSummaryUIModel])
}

// Default implementation
extension ConnectionDelegate {
    func onConnect() {}
    func onDisconnect() {}
    func onSendExchangeMarketObject(data: [GetExchangeSummaryUIModel]) {}
}
