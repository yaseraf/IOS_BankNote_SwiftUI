//
//  OrderEditDelegate.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/10/2025.
//

import Foundation

protocol OrderEditDelegate {
    func onCancelOrder()
    func onEditOrder(order: OrderListUIModel)
}
