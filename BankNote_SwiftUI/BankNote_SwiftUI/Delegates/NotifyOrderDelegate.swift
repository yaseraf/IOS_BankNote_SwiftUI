//
//  NotifyOrderDelegate.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/03/2026.
//

import Foundation

protocol NotifyOrderDelegate {
    func onNotifyOrder(newOrder: SendOrdersUIModel)
    func onNewOrder(newOrder: OrderListUIModel)
}
