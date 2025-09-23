//
//  AuthCoordinatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 22/07/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode

protocol AuthCoordinatorProtocol: AnyObject,Coordinator {
    func openLandingScene()
    func openCountiesScene(delegate: CountriesListDelegate,selectCountry:CountryFlagInfo?)
    func openForgotPasswordScene(forgotType:ForgotDataEnum)
    func openConfirmOtpScene(forgotType:ForgotDataEnum)
    func openChangePasswordScene()
    func openChangePinScene()
    func openSignUpScene(verificationType: VerificationType)
    func openVerifySignUpScene(verificationType: VerificationType, phone: String, email: String, otpExpirationTimer: Double, otpRequestID: String, transactionID: String, requestIDVlens: String, isVlens: Bool)
    func openChooseNationalityScene()
    func openLoginInformationScene()
    func openScanIDFrontScene()
    func openVerifyScanIDFrontScene()
    func openScanIDBackScene()
    func openVerifyScanIDBackScene()
    func openLivenessCheckScene()
    func openLivenessScanScene()
    func openQuestioneerScene()
    func openTermsAndConditionsScene()
    func openThanksForRegisteringScene()
    func openPinScene()
}
