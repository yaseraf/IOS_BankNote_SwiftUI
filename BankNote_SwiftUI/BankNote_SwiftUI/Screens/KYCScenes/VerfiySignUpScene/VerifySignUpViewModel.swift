//
//  VerifySignUpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import Combine
import MapKit

class VerifySignUpViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: KYCUseCaseProtocol
    var anyCancellable: AnyCancellable? = nil

    @Published var verificationType: VerificationType
    @Published var phone: String
    @Published var email: String
    @Published var pin: String = ""
    @Published var verifyPhoneOtpResponse: VerifyPhoneOtpUIModel?
    @Published var verifyEmailWithOtpResponse: VerifyEmailWithOtpUIModel?
    @Published var timerViewModel:OTPTimerViewModel
    @Published var otpExpirationTimer: Double?
    @Published var otpRequestID: String
    @Published var transactionID: String
    @Published var requestIDVlens: String
    @Published var isVlens: Bool = false

    @Published var verifyPhoneOtpAPIResult:APIResultType<VerifyPhoneOtpUIModel>?
    @Published var verifyEmailWithOtpAPIResult:APIResultType<VerifyEmailWithOtpUIModel>?
    @Published var getKYCCibcAPIResult:APIResultType<GetKYCCibcUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: KYCUseCaseProtocol, verificationType: VerificationType, phone: String, email: String, otpExpirationTimer: Double?, timerViewModel:OTPTimerViewModel, otpRequestID: String, transactionID: String, requestIDVlens:String, isVlens:Bool) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.verificationType = verificationType
        self.phone = phone
        self.email = email
        self.otpExpirationTimer = otpExpirationTimer
        self.timerViewModel =  timerViewModel
        self.otpRequestID = otpRequestID
        self.transactionID = transactionID
        self.requestIDVlens = requestIDVlens
        self.isVlens = isVlens
        
        anyCancellable = timerViewModel.objectWillChange.sink { [weak self] (_) in
               self?.objectWillChange.send()
           }
    }
}

// MARK: Routing
extension VerifySignUpViewModel {
    func openSignUpScene() {
        coordinator.openSignUpScene(verificationType: .email)
    }
    
    func openChooseNationalityScene() {
        coordinator.openChooseNationalityScene()
    }
    
    func nextScene(verifyWithEmail: Bool, phoneNumber: String){
        endTimerIfNeed()
        if !verifyWithEmail {
            coordinator.openSignUpScene(verificationType: verifyWithEmail ? .email : .phone)
        } else {
            coordinator.openChooseNationalityScene()
        }
    }

}

// MARK: API Calls
extension VerifySignUpViewModel {
    func verifyPhoneOtpAPI(success: Bool, phoneNumber: String, phoneNumberOtp: String, phoneNumberOtpRequestId: String, isVerifyingWithEmail: Bool) {
                
        let requestModel = VerifyPhoneOtpRequestModel(PhoneNumber: phoneNumber, PhoneNumberOtp: phoneNumberOtp, PhoneNumberOtpRequestId: phoneNumberOtpRequestId)
        
        verifyPhoneOtpAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.VerifyPhoneOtp(requestModel: requestModel) {[weak self] result in
                self?.verifyPhoneOtpAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("verify phone otp success")
                                        
                    if success.Data?.TransactionId != nil {
                        self?.verifyPhoneOtpResponse = success
                        KeyChainController().verifyPhoneOtpAccessToken = success.AccessToken
                        KeyChainController().verifyPhoneOtpRequestId = success.Request_Id
//                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "Success, \(success.ErrorCode ?? ""), \(success.ErrorMessage)")

                        self?.verifyPhoneOtpAPIResult = .onSuccess(response: success)
                        self?.nextScene(verifyWithEmail: isVerifyingWithEmail, phoneNumber: self?.phone ?? "")
                    } else {
                        self?.verifyPhoneOtpAPIResult = .onFailure(error: .custom(error: "Failed, \(success.ErrorMessage ?? "")"))
                    }
                    
                case .failure(let failure):
                        debugPrint("verify phone otp failed")
                        self?.verifyPhoneOtpAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    func verifyEmailOtpAPI(success: Bool, email: String, emailOtp: String, emailOtpRequestId: String, isVerifyingWithEmail: Bool) {
                
        let requestModel = VerifyEmailWithOtpRequestModel(Email: email, EmailOtp: emailOtp, EmailOtpRequestId: emailOtpRequestId, Request_Id: KeyChainController().verifyPhoneOtpRequestId)
        
        verifyEmailWithOtpAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.VerifyEmailWithOtp(requestModel: requestModel) {[weak self] result in
                self?.verifyEmailWithOtpAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    debugPrint("verify email with otp success")

                    if success.Data?.IsEmailConfirmed == true {
                        self?.verifyEmailWithOtpResponse = success
                        self?.verifyEmailWithOtpAPIResult = .onSuccess(response: success)
                        KeyChainController().emailOtpRequestId = success.Data?.EmailOtpRequestId
//                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "Success, \(success.ErrorCode ?? ""), \(success.ErrorMessage)")

                        self?.nextScene(verifyWithEmail: isVerifyingWithEmail, phoneNumber: self?.phone ?? "")
                    } else {
                        self?.verifyEmailWithOtpAPIResult = .onFailure(error: .custom(error: "Failed, \("otp_verification_failed".localized)"))
                    }
                    
                case .failure(let failure):
                        debugPrint("Incorrect OTP")
                        self?.verifyEmailWithOtpAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    func validateOtpBusinessAPI(success: Bool, otpCode:String) {
                
        var currentLocation: CLLocation?

        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

          currentLocation = UserData.shared.locManager.location

        }
        
        let longitude = String(currentLocation?.coordinate.longitude ?? 0.0)
        let latitude = String(currentLocation?.coordinate.latitude ?? 0.0)
        
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let requestModel = ValidateOtpBusinessRequestRequestModel(accessToken: KeyChainController().stepCreateAccessToken, geoLocation: ValidateOtpGeoLocation(latitude: latitude, longitude: longitude), otpCode: otpCode, otpRequestID: otpRequestID, requestID: KeyChainController().verifyPhoneOtpRequestId, requestIDVlens: requestIDVlens, transactionID: transactionID, userDeviceUTCTime: formatter.string(from: Date()))
        
        verifyPhoneOtpAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.ValidateOtpBusinessRequest(requestModel: requestModel) {[weak self] result in
                self?.verifyPhoneOtpAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
//                    debugPrint("validate success: \(success)")
                    
                    if success.errorCode != nil && success.errorCode != "" {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.errorMessage ?? "")")
                    } else {
                        UserDefaultController().investmentProductKeys?.removeFirst()

                        if UserDefaultController().investmentProductKeys?.isEmpty == false {
                            self?.coordinator.openTermsAndConditionsScene()
                        } else {
                            self?.getKYCCibcAPI(success: true, requestItems: [GetKYCCibcRequestItems(ID: "258", Value: "2")])
                            self?.coordinator.openThanksForRegisteringScene()
                        }
                    }
                    
                    
                case .failure(let failure):
                    debugPrint("validate failed")
                        self?.verifyPhoneOtpAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    func getKYCCibcAPI(success: Bool, requestItems: [GetKYCCibcRequestItems]) {
        
        let requestModel = GetKYCCibcRequestModel(RequestItems: requestItems, reqID: KeyChainController().verifyPhoneOtpRequestId)
        
        getKYCCibcAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.GetKYCCibc(requestModel: requestModel) {[weak self] result in
                self?.getKYCCibcAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    debugPrint("getKYCCibc success")
                    
                case .failure(let failure):
                        debugPrint("getKYCCibc failed")
                        self?.getKYCCibcAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}


// MARK Functions
extension VerifySignUpViewModel {
    func endTimerIfNeed() {
        timerViewModel.endTimerIfNeed()
    }

}
