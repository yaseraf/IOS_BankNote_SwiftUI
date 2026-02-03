//
//  AuthCoordinatorProtocol.swift
//  mahfazati
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
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
    func openSignUpScene(verificationType: VerificationType, verifyWithEmail: Bool)
    func openVerifySignUpScene(verificationType: VerificationType, phone: String, email: String, otpExpirationTimer: Double, otpRequestID: String, transactionID: String, requestIDVlens: String, isVlens: Bool)
    func openChooseNationalityScene()
    func openLoginInformationScene()
    func openLoginValifyScene()
    func openQuestionsScene()
    func openSetPasswordScene()
    func openCameraPreviewFor(type:CameraPreviewType, savedImageOne:Image?, stepIndexBind:Int, isFrontBind:Bool)
    func openVerifyIDConfirmation()
    func openTakeSelfieScene(livenessCheck:Bool)
    func openScanIDFrontScene(type: CameraPreviewType, savedImageOne:Image?, stepIndexBind:Int, isFrontBind:Bool)
    func openVerifyScanIDFrontScene(delegate:CameraPreviewDelegate, savedImageOne:Image?, isFrontID:Bool, address:String, name:String, dateOfBirth:String, idNumber:String, idKey:String)
    func openScanIDBackScene()
    func openVerifyScanIDBackScene(delegate:CameraPreviewDelegate, savedImageOne:Image?, isFrontID:Bool, gender:String, jobTitle:String, religion:String, maritalStatus:String)
    func openLivenessCheckScene()
    func openLivenessScanScene(type: CameraPreviewType, savedImageOne:Image?, stepIndexBind:Int, isFrontBind:Bool)
    func openQuestioneerScene()
    func openTermsAndConditionsScene()
    func openThanksForRegisteringScene()
    func openPinScene()
}
