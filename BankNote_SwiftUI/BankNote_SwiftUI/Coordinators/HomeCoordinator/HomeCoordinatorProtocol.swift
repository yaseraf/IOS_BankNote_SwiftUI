//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by FIT on 10/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol HomeCoordinatorProtocol: AnyObject,Coordinator {
    func openHomeScene()
    func openNotificationsScreen()
    func openTopUpScene(transactionType: TransactionTypes)
    func openPaymentMethodScene(transactionType: TransactionTypes)
    func openTransactionHistoryScene()
    func openTransactionSuccessfulScreen(transactionType: TransactionTypes)
}
