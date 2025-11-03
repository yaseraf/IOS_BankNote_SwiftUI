//
//  OrderListDelegate.swift
//  QSC_SwiftUI
//
//  Created by FIT on 02/09/2025.
//

import Foundation

protocol OrderListDelegate {
    func onOrderReceived(orders: [OrderListUIModel])
}
