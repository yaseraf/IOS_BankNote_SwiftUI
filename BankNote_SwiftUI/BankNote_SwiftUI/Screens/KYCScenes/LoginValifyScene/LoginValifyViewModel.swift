//
//  LoginInformationViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import MapKit
import FlagAndCountryCode

class LoginValifyViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: KYCUseCaseProtocol
    private let valifyUseCase: ValifyUseCaseProtocol

    @Published var getKYCCibcResponse: GetKYCCibcUIModel?
    @Published var stepCreateResponse: StepCreateUIModel?
    @Published var listPasswordValidation: [PasswordValidationType:ChangePasswordUIModel] = [:]
    @Published var isAllPasswordMatch:Bool = false
    @Published var phone:String = ""
    @Published var selectCountry: CountryFlagInfo?

    @Published var loginValifyAPIResult:APIResultType<LoginValifyUIModel>?
    @Published var getKycFieldAPIResult:APIResultType<GetKycFieldValifyUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: KYCUseCaseProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.valifyUseCase = valifyUseCase
        self.selectCountry = AppConstants.defaultEgyptCountry
        
        phone = KeyChainController().phoneNumberEntered ?? ""
    }
}

// MARK: Routing
extension LoginValifyViewModel {
    func openCountryPickerScene(countryModel:CountryFlagInfo?) {
        coordinator.openCountiesScene(delegate: self, selectCountry: countryModel)
    }
    
    func openContractsScene() {
        coordinator.openQuestioneerScene()
    }
}

// MARK: API Calls
extension LoginValifyViewModel {
    
    // MARK: Valify
    func loginValifyAPI(success: Bool, phone: String, password: String) {
        
        var currentLocation: CLLocation?

        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){

          currentLocation = UserData.shared.locManager.location

        }
        
        let longitude = String(currentLocation?.coordinate.longitude ?? 0.0)
        let latitude = String(currentLocation?.coordinate.latitude ?? 0.0)
                
        let timezone = TimeZone.current.identifier

        
//        let requestModel = LoginValifyRequestModel(lang: AppUtility.shared.isRTL ? "ar" : "en", password: password, phoneNumber: KeyChainController().phoneNumberEntered ?? "", reqID: KeyChainController().valifyRequestId ?? "")
        
        let requestModel = LoginValifyRequestModel(deviceId: UIDevice.current.identifierForVendor?.uuidString ?? "", deviceType: "IOS", ipAddress: "", lang: AppUtility.shared.isRTL ? "ar" : "en", latitude: latitude, longitude: longitude, password: password, phoneNumber: phone, timezone: "")
        
        loginValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.LoginValify(requestModel: requestModel) {[weak self] result in
                self?.loginValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.loginValifyAPIResult = .onSuccess(response: success)
                    debugPrint("LoginValify success")
                    
                    self?.coordinator.openQuestioneerScene()
                    
                    if success.internalErrorCode == "2010" {
//                        Error 2010: Device mismatch (Phone OTP Required)
//                        Call the below APIs:
//                        SendPhoneOtpValify
//                        VerifyPhoneOtpValify
//                        LoginValify
                        
                        self?.coordinator.openSignUpScene(verificationType: .phone, verifyWithEmail: false)
                        
                    } else if success.internalErrorCode == "2011" {
//                        Error 2011: Phone OTP failure (Email OTP Required)
//                        Call the below APIs:
//                        SendEmailOtpValify
//                        VerifyEmailOtpValify
//                        LoginValify
                        
                        self?.coordinator.openSignUpScene(verificationType: .email, verifyWithEmail: true)

                    } else if success.internalErrorCode == "2012" {
//                        Error 2012: Email OTP fallback (NID OCR required)
//                        Call the below APIs:
//                        GetFrontBackVilify (OCR)
//                        LoginValify
                        
                        self?.coordinator.openScanIDFrontScene(type: .scanMode(.nationalId), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)

                    } else if success.internalErrorCode == "2014" {
//                        Error 2014: Geolocation too far (Liveness + Face Match required)
//                        Call SDK:
//                        Face Match
//                        Liveness
//                        LoginValify
                        
                        self?.coordinator.openLivenessCheckScene()

                    }


                case .failure(let failure):
                        debugPrint("LoginValify failed, \(failure)")
                        self?.loginValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
}

// MARK: Functions
extension LoginValifyViewModel {
    private func setPasswordValidationList(){
         var listPasswordValidation : [PasswordValidationType:ChangePasswordUIModel] = [:]
         listPasswordValidation[.eightDigitCount] = .init( match: .none)
         listPasswordValidation[.atLeastOneNumber] = .init( match: .none)
         listPasswordValidation[.atLeastOneChar] = .init( match: .none)
        listPasswordValidation[.atLeastOneSpecialCharacter] = .init( match: .none)
        listPasswordValidation[.atLeastOneCapitalLetter] = .init( match: .none)
         self.listPasswordValidation = listPasswordValidation

     }
    
    func checkValidation(text:String){
        let hasNumber = text.rangeOfCharacter(from: .decimalDigits) != nil
          let hasCharacter = text.rangeOfCharacter(from: .letters) != nil
        let specialCharacterCheck = text.rangeOfCharacter(from: .alphanumerics.inverted) != nil
        let capitalLetterCheck = text.rangeOfCharacter(from: .uppercaseLetters) != nil
          let hasMinimumLength = text.count >= 8

        listPasswordValidation[.eightDigitCount] = .init( match: text.isEmpty ? .none : (hasMinimumLength ? .success : .failed))
        listPasswordValidation[.atLeastOneNumber] = .init( match: text.isEmpty ? .none : (hasNumber ? .success : .failed))
        listPasswordValidation[.atLeastOneChar] = .init( match: text.isEmpty ? .none : (hasCharacter ? .success : .failed))
        listPasswordValidation[.atLeastOneSpecialCharacter] = .init( match: text.isEmpty ? .none : (specialCharacterCheck ? .success : .failed))
        listPasswordValidation[.atLeastOneCapitalLetter] = .init( match: text.isEmpty ? .none : (capitalLetterCheck ? .success : .failed))

    }

    func  checkIsAllPasswordMatch(){
            let count = Array(listPasswordValidation.values).filter({
                $0.match == .success
            }).count

        isAllPasswordMatch = count == listPasswordValidation.count

    }
}

// MARK: Delegates
extension LoginValifyViewModel: CountriesListDelegate {
    func onSelectCountry(model: CountryFlagInfo) {
        self.selectCountry = model
    }
    
    func onSelect(model: CountryUIModel) {
        
    }
}
