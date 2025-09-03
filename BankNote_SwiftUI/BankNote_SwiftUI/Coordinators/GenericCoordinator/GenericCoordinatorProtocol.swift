//
//  HomeCoorindatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol GenericCoordinatorProtocol: AnyObject,Coordinator {
    func openSelectSharesScene(delegate: SelectSharesDelegate)
    func openSelectBankScene(delegate: SelectBankDelegate, selectedBank: BankUIModel?)
    func openCancelConfirmationScene(transactionType: TransactionTypes)
    func openRangeCalendarScene(delegate: RangeCalendarDelegate, title: String?, isMultiSelect: Bool?)
    func openAlertsScene()
    func openAddAlertScene()
    func openSelectPriceFactorScene(delegate: SelectPriceFactorDelegate)
}
