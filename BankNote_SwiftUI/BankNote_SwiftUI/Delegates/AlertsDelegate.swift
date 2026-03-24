//
//  AlertsDelegate.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/03/2026.
//

import Foundation
protocol AlertsDelegate{
    func onReceiveAlert(model:NotificationUIModel)
    func onReceiveCount()
    func onReceiveNews(model: MarketNewsObject)
}
