//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by FIT on 10/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol OrdersCoordinatorProtocol: AnyObject,Coordinator {
    func openOrdersScene()
    func openOrderEntryScene(orderDetails: OrderListUIModel, placeOrderType: PlaceOrderType, isEditOrder: Bool)
    func openOrderDetailsScene(orderPreview: OrderListUIModel, riskManagementData: GetRiskManagementUIModel, isEditOrder: Bool)
    func openOrderEditScene(orderDetails: OrderListUIModel, delegate: OrderEditDelegate)
}
