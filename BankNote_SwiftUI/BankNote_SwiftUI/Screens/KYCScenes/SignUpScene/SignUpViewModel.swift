//
//  SignUpViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import FlagAndCountryCode
import MapKit
import CoreLocation

class SignUpViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: KYCUseCaseProtocol
    private let valifyUseCase: ValifyUseCaseProtocol
    
    @Published var verificationType: VerificationType?
    @Published var phone: String = ""
    @Published var email: String = ""
    @Published var getAccessTokenResponse: GetAccessTokenUIModel?
    @Published var stepVerifyPhoneResponse: StepVerifyPhoneUIModel?
    @Published var stepVerifyEmailResponse: StepVerifyEmailUIModel?
    @Published var verifyWithEmail: Bool?
    @Published var showPasswordField: Bool = false
    @Published var locationPermissionDenied: Bool = false
    @Published var selectCountry: CountryFlagInfo?

    @Published var getAccessTokenAPIResult:APIResultType<GetAccessTokenUIModel>?
    @Published var stepVerifyPhoneAPIResult:APIResultType<StepVerifyPhoneUIModel>?
    @Published var getCurrentListIdsAPIResult:APIResultType<GetCurrentListIdsUIModel>?
    @Published var stepVerifyEmailAPIResult:APIResultType<StepVerifyEmailUIModel>?
    @Published var loginVlensAPIResult:APIResultType<LoginVlensUIModel>?
    
    // MARK: VALIFY
    @Published var sendPhoneOtpValifyAPIResult:APIResultType<SendPhoneOtpValifyUIModel>?
    @Published var sendEmailOtpValifyAPIResult:APIResultType<SendEmailOtpValifyUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: KYCUseCaseProtocol, valifyUseCase: ValifyUseCaseProtocol, verificationType: VerificationType, verifyWithEmail: Bool) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.valifyUseCase = valifyUseCase
        
        self.verificationType = verificationType
        self.verifyWithEmail = verifyWithEmail
        self.selectCountry = AppConstants.defaultEgyptCountry
        checkLocationAuthorization()
        

    }
    
    
}

// MARK: Routing
extension SignUpViewModel {
    func openVerifySignUpScene(transactionID: String, verifyWithEmail: Bool, phoneNumber: String, email: String) {
        coordinator.openVerifySignUpScene(verificationType: verifyWithEmail ? .email : .phone, phone: phoneNumber, email: email, otpExpirationTimer: 60, otpRequestID: "", transactionID: transactionID, requestIDVlens: "", isVlens: false)
    }

    func openCountryPickerScene(countryModel:CountryFlagInfo?) {
        coordinator.openCountiesScene(delegate: self, selectCountry: countryModel)
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension SignUpViewModel {
    
    // MARK: VALIFY
    
    func sendPhoneOtpValifyAPI(phoneNumber: String) {
        let requestModel = SendPhoneOtpValifyRequestModel(Lang: AppUtility.shared.isRTL ? "ar" : "en", PhoneNumber: phoneNumber, reqID: KeyChainController().valifyRequestId ?? "")
        
        KeyChainController().phoneNumberEntered = phoneNumber
        
        sendPhoneOtpValifyAPIResult = .onLoading(show: true)
        
        Task.init {
            await valifyUseCase.SendPhoneOtpValify(requestModel: requestModel) {[weak self] result in
                self?.sendPhoneOtpValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    if success.IsSuccessful ?? false {
                        self?.openVerifySignUpScene(transactionID: success.TransactionId ?? "", verifyWithEmail: self?.verifyWithEmail ?? false, phoneNumber: phoneNumber, email: "")
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.ErrorMsg ?? "")
                    }


                    debugPrint("Send phone otp valify success")
                    
                case .failure(let failure):
                    self?.sendPhoneOtpValifyAPIResult = .onFailure(error: failure)
                    debugPrint("Send phone otp valify failed: \(failure)")
                }
            }
        }
    }
    
    func sendEmailOtpValifyAPI(email:String) {
        let requestModel = SendEmailOtpValifyRequestModel(Email: email, Lang: AppUtility.shared.isRTL ? "ar" : "en", reqID: KeyChainController().valifyRequestId)
        
        sendEmailOtpValifyAPIResult = .onLoading(show: true)
        
        Task.init {
            await valifyUseCase.SendEmailOtpValify(requestModel: requestModel) {[weak self] result in
                self?.sendEmailOtpValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    if success.IsSuccessful ?? false {
                        self?.openVerifySignUpScene(transactionID: success.TransactionId ?? "", verifyWithEmail: self?.verifyWithEmail ?? false, phoneNumber: "", email: email)
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.ErrorMsg ?? "")
                    }


                    debugPrint("Send email otp valify success")
                    
                case .failure(let failure):
                    self?.sendEmailOtpValifyAPIResult = .onFailure(error: failure)
                    debugPrint("Send email otp valify failed: \(failure)")
                }
            }
        }
    }

    
    
    
    func getAccessTokenAPI(success: Bool) {
        debugPrint("Called getAccessToken API")

        let requestModel = GetAccessTokenRequestModel(Client_ID: "8", Client_Secret: "SIBFIT3cR3t", Reference_No: "")
        getAccessTokenAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetAccessToken(requestModel: requestModel) {[weak self] result in
                self?.getAccessTokenAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("Get access token success")
                    
                    if success.resData?.access_token != nil {
                        self?.getAccessTokenAPIResult = .onSuccess(response: success)
                        self?.getAccessTokenResponse = success
                        if self?.verifyWithEmail == false {
                            KeyChainController().accessToken = success.resData?.access_token
                        }
                    } else {
                        self?.getAccessTokenAPIResult = .onFailure(error: .custom(error: "Failed, \(success.Error_code ?? "")"))
                    }

                case .failure(let failure):
                        debugPrint("Get access token failed")
                        self?.getAccessTokenAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func loginVlensAPI(success: Bool, phoneNumber: String, password: String, uiModel: VerifyOTPUIModel, verifyWithEmail: Bool) {
        debugPrint("Called loginVlens API")

        var currentLocation: CLLocation?

        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

          currentLocation = UserData.shared.locManager.location

        }
        
        let longitude = String(currentLocation?.coordinate.longitude ?? 0.0)
        let latitude = String(currentLocation?.coordinate.latitude ?? 0.0)
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            print(uuid)
        }
        
        let requestModel = LoginVlensRequestModel(GeoLocation: LoginVlensGeoLocation(Latitude: latitude, Longitude: longitude), Imei: UIDevice.current.identifierForVendor?.uuidString ?? ""              , Password: password, PhoneNumber: phoneNumber, phoneNumberOtp: "", phoneNumberOtpRequestId: "")
        
//        SceneDelegate.getAppC oordinator()?.showMessage(type: .failure,"\(requestModel)")

        loginVlensAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.loginVlens(requestModel: requestModel) {[weak self] result in
                self?.loginVlensAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("loginVlens success")
//                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(success)")

                    if success.Data.phoneNumberOtpRequestID != "" && success.Data.phoneNumberOtpRequestID != nil {
                        KeyChainController().phoneNumberOtpRequestId = success.Data.phoneNumberOtpRequestID
//                        self?.openVerifySignUpScene(uiModel: uiModel, verifyWithEmail: verifyWithEmail, phoneNumber: phoneNumber, email: "", otpExpirationTimer: Double(success.Data.phoneOtpExpireInSeconds ?? 0)) // In minutes
                       
                    } else {
                        
                        if success.HeaderAccessToken == "" {
                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(success.ErrorMessage)")
                            return
                        }
                        
                        if success.Data.isDigitalIdentityVerified == true {
                            if success.ACTION_ID != "1" {
//                                self?.coordinator.openTermsAndConditionsScene()
                                KeyChainController().stepCreateAccessToken = success.Data.accessToken
                                KeyChainController().loginVlensAccessToken = success.HeaderAccessToken
                                self?.coordinator.openThanksForRegisteringScene()
//                                self?.coordinator.openQuestionnaireRegisterScene()

                            } else if success.ACTION_ID == "1" {
                                KeyChainController().stepCreateAccessToken = success.Data.accessToken
                                KeyChainController().loginVlensAccessToken = success.HeaderAccessToken
                                debugPrint("Header acces token: \(success.HeaderAccessToken)")
                                
                                self?.getCurrentListIdsAPI()
                                
                                self?.coordinator.openQuestioneerScene()
                            }
                        } else {
                            KeyChainController().stepCreateAccessToken = success.Data.accessToken
                            KeyChainController().loginVlensAccessToken = success.HeaderAccessToken
                            debugPrint("Header acces token: \(success.HeaderAccessToken)")
                            self?.coordinator.openCameraPreviewFor(type: .scanMode(.nationalId), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)
                        }
                        
                    }
                    
                case .failure(let failure):
                        debugPrint("loginVlens failed")
//                        self?.loginVlensAPIResult = .onFailure(error: failure)
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(failure)")

                    self?.stepVerifyPhoneAPIResult = .onFailure(error: .custom(error: "Please enter your password again."))

                }
            }
        }
    }
    
    func getCurrentListIdsAPI() {
        debugPrint("Called stepVerifyPhone API")
        let requestModel = GetCurrentListIdsRequestModel(accessToken: KeyChainController().stepCreateAccessToken ?? "")
        
        getCurrentListIdsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetCurrentListIds(requestModel: requestModel) {[weak self] result in
                self?.getCurrentListIdsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    UserDefaultController().completedInvestmentProductKeys = success.data.reduce(into: [String: String]()) { result, item in
                        if let id = item.contractTypeId, let status = item.requestStatus {
                            result[id] = status
                        }
                    }

                    debugPrint("Get current list ids success")
                    
                case .failure(let failure):
                    self?.getCurrentListIdsAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
    
    func checkEmailOrPhoneExistence(email: String, phoneNumber: String, password: String, uiModel: VerifyOTPUIModel, verifyWithEmail: Bool) {

        let requestModel = CheckEmailOrPhoneExistenceRequestModel(email: email, phoneNumber: phoneNumber)
        
        stepVerifyEmailAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.CheckEmailOrPhoneExistence(requestModel: requestModel) {[weak self] result in
                self?.stepVerifyEmailAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("check existence success")
                    
                    if success.errorCode == nil && success.data?.isPhoneNumberExists ?? false { // Phone number existing
                        self?.showPasswordField = true
                    } else {
                        self?.stepVerifyPhoneAPI(success: true, phoneNumber: phoneNumber, phoneNumberOtp: "", phoneNumberOtpRequestId: "", uiModel: uiModel, verifyWithEmail: verifyWithEmail)
                    }
                    if success.errorCode != nil && success.errorCode?.count ?? 0 > 0 {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(success.errorMessage ?? "")")
                    }
                    
                case .failure(let failure):
                    debugPrint("check existence failed")

                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(failure)")
                    self?.stepVerifyEmailAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
    
    func stepVerifyPhoneAPI(success: Bool, phoneNumber: String, phoneNumberOtp: String, phoneNumberOtpRequestId: String, uiModel: VerifyOTPUIModel, verifyWithEmail: Bool) {
        debugPrint("Called stepVerifyPhone API")
        let requestModel = StepVerifyPhoneRequestModel(phoneNumber: phoneNumber, phoneNumberOtp: phoneNumberOtp, phoneNumberOtpRequestId: phoneNumberOtpRequestId)
        
        stepVerifyPhoneAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.StepVerifyPhone(requestModel: requestModel) {[weak self] result in
                self?.stepVerifyPhoneAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("step verify phone success")
                    
//                    if success.Data?.TransactionId != nil {
                    if success.ErrorCode != "-5" && success.ErrorCode != "6102" && success.ErrorCode?.isEmpty == true {
                        self?.stepVerifyPhoneAPIResult = .onSuccess(response: success)
//                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "Success, \(success.ErrorCode ?? ""), \(success.ErrorMessage ?? "")")

                        
                        self?.stepVerifyPhoneResponse = success
                        KeyChainController().phoneNumberOtpRequestId = success.Data?.PhoneNumberOtpRequestId

//                        self?.openVerifySignUpScene(uiModel: uiModel, verifyWithEmail: verifyWithEmail, phoneNumber: phoneNumber, email: "", otpExpirationTimer: (success.Data?.PhoneOtpExpireInSeconds ?? 0)) // In minutes
                    } else {
//                        self?.stepVerifyPhoneAPIResult = .onFailure(error: .custom(error: "Failed, \(success.ErrorCode ?? ""), \(success.ErrorMessage ?? "")"))
                        
                        
                        
                        // If phone number already exists
                        // Add a password field
                        
                        if success.ErrorCode == "6102" {
                            self?.showPasswordField = true
                        } else {
                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(success.ErrorMessage ?? "")")
                        }

                    }
                    
                    
                case .failure(let failure):
                        debugPrint("step verify phone failed")
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(failure)")

                        self?.stepVerifyPhoneAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    func stepVerifyEmailAPI(success: Bool, email: String, emailOtp: String, emailOtpRequestId: String, requestId: String, uiModel: VerifyOTPUIModel, verifyWithEmail: Bool) {
        debugPrint("Called stepVerifyEmail API")

        let requestModel = StepVerifyEmailRequestModel(Email: email, EmailOtp: emailOtp, EmailOtpRequestId: emailOtpRequestId, Request_Id: requestId)
        
        stepVerifyEmailAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.StepVerifyEmail(requestModel: requestModel) {[weak self] result in
                self?.stepVerifyEmailAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("step verify email success")
                    
                    if success.Data?.TransactionId != nil {
                        self?.stepVerifyEmailAPIResult = .onSuccess(response: success)
                        self?.stepVerifyEmailResponse = success
                        KeyChainController().emailOtpRequestId = success.Data?.EmailOtpRequestId
//                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "Success, \(success.ErrorCode ?? ""), \(success.ErrorMessage ?? "")")

//                        self?.openVerifySignUpScene(uiModel: uiModel, verifyWithEmail: verifyWithEmail, phoneNumber: "", email: email, otpExpirationTimer: (success.Data?.EmailOtpExpireInSeconds ?? 0)) // In minutes
                    } else {
                        self?.stepVerifyEmailAPIResult = .onFailure(error: .custom(error: "Failed, \(success.ErrorMessage ?? "")"))
                    }
                    
                    
                case .failure(let failure):
                        debugPrint("step verify email failed")
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,"\(failure)")

                        self?.stepVerifyEmailAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }


}

// MARK: Delegates
extension SignUpViewModel: CountriesListDelegate {
    func onSelectCountry(model: CountryFlagInfo) {
        self.selectCountry = model
    }
    
    func onSelect(model: CountryUIModel) {
        
    }
}


// MARK: Functions
extension SignUpViewModel {
    func checkLocationAuthorization() {
        let status = UserData.shared.locManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("Not determined yet")
            UserData.shared.locManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Denied ❌")
            DispatchQueue.main.async {
                self.locationPermissionDenied = true
            }
        case .authorizedWhenInUse, .authorizedAlways:
            print("Allowed ✅")
            DispatchQueue.main.async {
                self.locationPermissionDenied = false
            }
        @unknown default:
            break
        }
    }
}
