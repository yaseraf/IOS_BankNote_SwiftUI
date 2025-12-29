//
//  LoginInformationViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import MapKit

struct ChangePasswordUIModel{
    var match:OptionsType
}

class SetPasswordViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: KYCUseCaseProtocol
    private let valifyUseCase: ValifyUseCaseProtocol

    @Published var getKYCCibcResponse: GetKYCCibcUIModel?
    @Published var stepCreateResponse: StepCreateUIModel?
    @Published var listPasswordValidation: [PasswordValidationType:ChangePasswordUIModel] = [:]
    @Published var isAllPasswordMatch:Bool = false

    @Published var getKYCCibcAPIResult:APIResultType<GetKYCCibcUIModel>?
    @Published var stepCreateAPIResult:APIResultType<StepCreateUIModel>?
    @Published var registerValifyAPIResult:APIResultType<RegisterValifyUIModel>?
    @Published var csoValifyAPIResult:APIResultType<CsoValifyUIModel>?
    @Published var ntraValifyAPIResult:APIResultType<NtraValifyUIModel>?
    @Published var setPasswordValifyAPIResult:APIResultType<SetPasswordValifyUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: KYCUseCaseProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.valifyUseCase = valifyUseCase
    }
}

// MARK: Routing
extension SetPasswordViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    func openScanIDFrontScene() {
//        coordinator.openScanIDFrontScene()
        coordinator.openCameraPreviewFor(type: .scanMode(.nationalId), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)
    }
    
    func openLoginValifyScene() {
        coordinator.openLoginValifyScene()
    }
}

// MARK: API Calls
extension SetPasswordViewModel {
    
    // MARK: Valify
    func setPasswordValifyAPI(success: Bool, password: String) {
        
        let requestModel = SetPasswordValifyRequestModel(
            lang: AppUtility.shared.isRTL ? "ar" : "en",
            password: password,
            accessToken: KeyChainController().valifyAccessToken ?? "",
            reqID: KeyChainController().valifyRequestId ?? ""
        )
        
        setPasswordValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.SetPasswordValify(requestModel: requestModel) {[weak self] result in
                self?.setPasswordValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.setPasswordValifyAPIResult = .onSuccess(response: success)
                    
                    if success.isSuccessful == true {
                        debugPrint("setPasswordValify success")
                        self?.openLoginValifyScene()
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.serverResponse ?? "")
                    }
                                        
                case .failure(let failure):
                        debugPrint("setPasswordValify failed")
                        self?.setPasswordValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
}

// MARK: Functions
extension SetPasswordViewModel {
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
