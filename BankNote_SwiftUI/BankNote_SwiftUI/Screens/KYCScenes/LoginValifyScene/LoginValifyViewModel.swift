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

    init(coordinator: AuthCoordinatorProtocol, useCase: KYCUseCaseProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.valifyUseCase = valifyUseCase
        self.selectCountry = AppConstants.defaultEgyptCountry

    }
}

// MARK: Routing
extension LoginValifyViewModel {
    func openCountryPickerScene(countryModel:CountryFlagInfo?) {
        coordinator.openCountiesScene(delegate: self, selectCountry: countryModel)
    }
}

// MARK: API Calls
extension LoginValifyViewModel {
    
    // MARK: Valify
    func loginValifyAPI(success: Bool, phone: String, password: String) {
        
        let requestModel = LoginValifyRequestModel(lang: AppUtility.shared.isRTL ? "ar" : "en", password: password, phoneNumber: phone, reqID: KeyChainController().valifyRequestId ?? "")
        
        loginValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.LoginValify(requestModel: requestModel) {[weak self] result in
                self?.loginValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.loginValifyAPIResult = .onSuccess(response: success)
                    debugPrint("LoginValify success")
                                        
                case .failure(let failure):
                        debugPrint("LoginValify failed")
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
