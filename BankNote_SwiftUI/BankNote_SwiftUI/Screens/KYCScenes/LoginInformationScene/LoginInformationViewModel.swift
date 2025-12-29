//
//  LoginInformationViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import MapKit

//struct ChangePasswordUIModel{
//    var match:OptionsType
//}

class LoginInformationViewModel: ObservableObject {
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
extension LoginInformationViewModel {
    func popViewController() {
        coordinator.popViewController(animated: true)
    }
    func openScanIDFrontScene() {
//        coordinator.openScanIDFrontScene()
        coordinator.openCameraPreviewFor(type: .scanMode(.nationalId), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)
    }
    
    func openLoginValifyScene() {
        coordinator.openLoginValifyScene()
    }
    
    func openQuestionsScene() {
        coordinator.openQuestioneerScene()
    }
}

// MARK: API Calls
extension LoginInformationViewModel {
    
    // MARK: Valify
    
    func csoValifyAPI(success: Bool, username:String, password:String) {
        
        let requestModel = CsoValifyRequestModel(
            bundleSessionId: "",
            expiration: "",
            firstName: "",
            fullName: KeyChainController().phoneNumberEntered ?? "",
            nid: "",
            serialNumber: KeyChainController().valifyRequestId ?? "",
            reqID: KeyChainController().valifyRequestId ?? ""
        )
        
        csoValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.CsoValify(requestModel: requestModel) {[weak self] result in
                self?.csoValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    if success.isSuccessful ?? false {
                        self?.csoValifyAPIResult = .onSuccess(response: success)
                        self?.ntraValifyAPI(success: true, username: username, password: password)
                        
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.serverResponse ?? "")
                    }
                                        
                case .failure(let failure):
                        debugPrint("RegisterValify failed")
                        self?.csoValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func ntraValifyAPI(success: Bool, username:String, password:String) {
        
        let requestModel = NtraValifyRequestModel(
            bundleSessionId: "",
            nid: "",
            phoneNumber: KeyChainController().phoneNumberEntered ?? "",
            reqID: KeyChainController().valifyRequestId ?? ""
        )
        
        ntraValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.NtraValify(requestModel: requestModel) {[weak self] result in
                self?.ntraValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    if success.isSuccessful ?? false {
                        self?.ntraValifyAPIResult = .onSuccess(response: success)
                        self?.registerValifyAPI(success: true)
                        
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.serverResponse ?? "")
                    }
                                        
                case .failure(let failure):
                        debugPrint("RegisterValify failed")
                        self?.ntraValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func registerValifyAPI(success: Bool) {
        
        let requestModel = RegisterValifyRequestModel(
            lang: AppUtility.shared.isRTL ? "ar" : "en",
            name: KeyChainController().phoneNumberEntered ?? "",
            userReferenceId: KeyChainController().valifyRequestId ?? "",
            reqID: KeyChainController().valifyRequestId ?? ""
        )
        
        registerValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.RegisterValify(requestModel: requestModel) {[weak self] result in
                self?.registerValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "Message: \(success.message ?? "")")
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "Server response: \(success.serverResponse ?? "")")
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "scope: \(success.scope ?? "")")
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "errormsg: \(success.errorMsg ?? "")")
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "IsSuccessful: \(String(success.isSuccessful ?? false))")

                    if success.isSuccessful ?? false {
                        self?.registerValifyAPIResult = .onSuccess(response: success)
                        debugPrint("RegisterValify success")
//                        self?.setPasswordValifyAPI(success: true, password: password)
                        KeyChainController().valifyAccessToken = success.accessToken
                        self?.openQuestionsScene()
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.serverResponse ?? "")
                    }
                                        
                case .failure(let failure):
                        debugPrint("RegisterValify failed")
                        self?.registerValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func setPasswordValifyAPI(success: Bool, password: String) {
        
        let requestModel = SetPasswordValifyRequestModel(
            lang: AppUtility.shared.isRTL ? "ar" : "en",
            password: password,
            accessToken: KeyChainController().accessToken ?? "",
            reqID: KeyChainController().valifyRequestId ?? ""
        )
        
        setPasswordValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.SetPasswordValify(requestModel: requestModel) {[weak self] result in
                self?.setPasswordValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.setPasswordValifyAPIResult = .onSuccess(response: success)
                    debugPrint("setPasswordValify success")
                    self?.openLoginValifyScene()
                                        
                case .failure(let failure):
                        debugPrint("setPasswordValify failed")
                        self?.setPasswordValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

    // MARK: VLens
    func getKYCCibcAPI(success: Bool, requestItems: [GetKYCCibcRequestItems], password: String) {
        
        let requestModel = GetKYCCibcRequestModel(RequestItems: requestItems, reqID: KeyChainController().verifyPhoneOtpRequestId)
        
        getKYCCibcAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.GetKYCCibc(requestModel: requestModel) {[weak self] result in
                self?.getKYCCibcAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("getKYCCibc success")
                    
                    if success.ErrorCode == "0" || success.ErrorCode == ""  {
                        self?.getKYCCibcAPIResult = .onSuccess(response: success)
                        self?.getKYCCibcResponse = success
                        self?.stepCreateAPI(success: true, password: password)
                    } else {
                        self?.getKYCCibcAPIResult = .onFailure(error: .custom(error: success.ErrorMessage ?? ""))
                    }
                    
                case .failure(let failure):
                        debugPrint("getKYCCibc failed")
                        self?.getKYCCibcAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func stepCreateAPI(success: Bool, password: String) {
        
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
        
        let requestModel = StepCreateRequestModel(EmailOtpRequestId: KeyChainController().emailOtpRequestId, GeoLocation: GeoLocationData(Latitude: latitude, Longitude: longitude), Imei: UIDevice.current.identifierForVendor?.uuidString, Password: password, PhoneNumberOtpRequestId: KeyChainController().phoneNumberOtpRequestId, Request_Id: KeyChainController().verifyPhoneOtpRequestId, PhoneNumber: KeyChainController.shared().phoneNumberEntered)
        
        stepCreateAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.StepCreate(requestModel: requestModel) {[weak self] result in
                self?.stepCreateAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("step create success")
                    
                    if success.Data?.AccessToken != nil {
                        self?.stepCreateAPIResult = .onSuccess(response: success)
                        self?.stepCreateResponse = success
                        KeyChainController().savedUserPassword = password
                        KeyChainController().stepCreateAccessToken = success.Data?.AccessToken
                        self?.openScanIDFrontScene()
                    } else {
                        self?.stepCreateAPIResult = .onFailure(error: .custom(error: success.ErrorMessage ?? ""))
                    }
                      
                case .failure(let failure):
                        debugPrint("step create failed")
                        self?.stepCreateAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}

// MARK: Functions
extension LoginInformationViewModel {
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
