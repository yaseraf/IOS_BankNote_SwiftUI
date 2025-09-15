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
    func openLoginScene()
    func openLandingScene()
    func openCountryPickerScene()
    func openVerifyOtpScene(username: String, password: String)
    func openForgotPasswordScene(forgotType:ForgotDataEnum)
    func openConfirmOtpScene(forgotType:ForgotDataEnum)
    func openChangePasswordScene()
    func openChangePinScene()
    func openSignUpScene(verificationType: VerificationType)
    func openVerifySignUpScene(verificationType: VerificationType, phone: String, email: String)
    func openChooseNationalityScene()
    func openLoginInformationScene()
    func openScanIDFrontScene()
    func openVerifyScanIDFrontScene()
    func openScanIDBackScene()
    func openVerifyScanIDBackScene()
    func openLivenessCheckScene()
}
