//
//  AuthCoordinator.swift
//  mahfazati
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode


enum AuthStartSceneType{
    case login
    case boarding
    case register
}

class AuthCoordinator:  ObservableObject {
    var childCoordinator: [Coordinator] = []
    var navigationController: BaseNavigationController
    var startViewType: AuthStartSceneType

    init(navigationController: BaseNavigationController,startViewType:AuthStartSceneType) {
        self.navigationController = navigationController
        self.startViewType = startViewType
    }

    func updateStartViewType(_ type: AuthStartSceneType) {
        self.startViewType = type
    }

    func start() {
        self.navigationController.viewControllers = []
        switch startViewType {
        case .login:
            openLandingScene()
        case .boarding:
            openLandingScene()
        case .register:
            openLandingScene()
        }
    }

    func restart() {
        start()
    }
    
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func openLandingScene() {
        let useCase = AuthUseCase()
        let viewModel = LandingViewModel(coordinator: self, useCase: useCase)
        let view = LandingScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openCountiesScene(delegate: CountriesListDelegate,selectCountry:CountryFlagInfo?) {
        let viewModel = CountriesListViewModel(coordinator:self,delegate: delegate, selectCountry: selectCountry)
        let view =  CountriesListScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        SceneDelegate.getAppCoordinator()?.topViewController()?.present(viewController, animated: true)
    }
    func openForgotPasswordScene(forgotType: ForgotDataEnum) {
        let viewModel = ForgotPasswordViewModel(coordinator: self, forgotType: forgotType)
        let view = ForgotPasswordScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openConfirmOtpScene(forgotType: ForgotDataEnum) {
        let viewModel = ConfirmOtpPopupViewModel(coordinator: self, forgotType: forgotType)
        let view = ConfirmOtpPopupScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
        
    func openChangePasswordScene() {
        let viewModel = ChangePasswordViewModel(coordinator: self)
        let view = ChangePasswordScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openChangePinScene() {
        let viewModel = ChangePinViewModel(coordinator: self)
        let view = ChangePinScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openSignUpScene(verificationType: VerificationType, verifyWithEmail: Bool) {
        let useCase = KYCUseCase()
        let valifyUseCase = ValifyUseCase()
        let viewModel = SignUpViewModel(coordinator: self, useCase: useCase, valifyUseCase: valifyUseCase, verificationType: verificationType, verifyWithEmail: verifyWithEmail)
        let view = SignUpScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openVerifySignUpScene(verificationType: VerificationType, phone: String, email: String, otpExpirationTimer: Double, otpRequestID: String, transactionID: String, requestIDVlens: String, isVlens: Bool) {
        
        let useCase = KYCUseCase()
        let valifyUseCase = ValifyUseCase()
        let viewModel = VerifySignUpViewModel(coordinator: self, useCase: useCase, valifyUseCase: valifyUseCase, verificationType: verificationType, phone: phone, email: email, otpExpirationTimer: otpExpirationTimer, timerViewModel: .init(), otpRequestID: otpRequestID, transactionID: transactionID, requestIDVlens: requestIDVlens, isVlens: isVlens)
        let view = VerifySignUpScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openChooseNationalityScene() {
        let useCase = KYCUseCase()
        let viewModel = ChooseNationalityViewModel(coordinator: self, useCase: useCase)
        let view = ChooseNationalityScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openLoginInformationScene() {
        let useCase = KYCUseCase()
        let valifyUseCase = ValifyUseCase()
        let viewModel = LoginInformationViewModel(coordinator: self, useCase: useCase, valifyUseCase: valifyUseCase)
        let view = LoginInformationScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openLoginValifyScene() {
        let useCase = KYCUseCase()
        let valifyUseCase = ValifyUseCase()
        let viewModel = LoginValifyViewModel(coordinator: self, useCase: useCase, valifyUseCase: valifyUseCase)
        let view = LoginValifyScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    
    func openCameraPreviewFor(type: CameraPreviewType, savedImageOne:Image?, stepIndexBind:Int, isFrontBind:Bool) {
        let kycUseCase = KYCUseCase()
        let valifyUseCase = ValifyUseCase()
        let viewModel = CameraPreviewViewModel(coordinator: self, kycUseCase: kycUseCase, valifyUseCase: valifyUseCase, viewType: type, savedImageOne: savedImageOne, stepIndexBind: stepIndexBind, isFrontBind: isFrontBind)
        let view =  CameraPreviewScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        
//        DispatchQueue.main.async{
//            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
            let viewController = UIHostingController(rootView: viewWithCoordinator)
//            self.navigationController.pushViewController(viewController, animated: true)
        
            viewController.modalPresentationStyle = .fullScreen
            SceneDelegate.getAppCoordinator()?.topViewController()?.present(viewController, animated: true)
//        }
    }
    
    func openVerifyIDConfirmation(delegate:CameraPreviewDelegate, savedImageOne:Image?, isFrontID:Bool, address:String, name:String, dateOfBirth:String, idNumber:String, idKey:String, gender:String, jobTitle:String, religion:String, maritalStatus:String) {
        let viewModel = VerifyIDConfirmationViewModel(coordinator: self, delegate: delegate, savedImageOne: savedImageOne, isFrontID: isFrontID, address: address, name: name, dateOfBirth: dateOfBirth, idNumber: idNumber, idKey: idKey, gender: gender, jobTitle: jobTitle, religion: religion, maritalStatus: maritalStatus)
        let view =  VerifyIDConfirmationScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
        self.navigationController.dismiss(animated: true)
    }

    func openTakeSelfieScene(livenessCheck:Bool){
        let viewModel = TakeSelfieViewModel(coordinator: self,isLivenessCheck: livenessCheck)
        let view = TakeSelfieScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
        
    func openScanIDFrontScene(type: CameraPreviewType, savedImageOne:Image?, stepIndexBind:Int, isFrontBind:Bool) {
        let kycUseCase = KYCUseCase()
        let valifyUseCase = ValifyUseCase()
        //        let viewModel = ScanIDFrontViewModel(coordinator: self, kycUseCase: kycUseCase, valifyUseCase: valifyUseCase, viewType: type, savedImageOne: savedImageOne, stepIndexBind: stepIndexBind, isFrontBind: isFrontBind)
        let viewModel = CameraPreviewViewModel(coordinator: self, kycUseCase: kycUseCase, valifyUseCase: valifyUseCase, viewType: type, savedImageOne: savedImageOne, stepIndexBind: stepIndexBind, isFrontBind: isFrontBind)
        let view = ScanIDFrontScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openVerifyScanIDFrontScene(delegate:CameraPreviewDelegate, savedImageOne:Image?, isFrontID:Bool, address:String, name:String, dateOfBirth:String, idNumber:String, idKey:String) {
        let viewModel = VerifyScanIDFrontViewModel(coordinator: self, delegate: delegate, savedImageOne: savedImageOne, isFrontID: isFrontID, address: address, name: name, dateOfBirth: dateOfBirth, idNumber: idNumber, idKey: idKey)
        let view = VerifyScanIDFrontScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openScanIDBackScene() {
        let viewModel = ScanIDBackViewModel(coordinator: self)
        let view = ScanIDBackScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openVerifyScanIDBackScene(delegate:CameraPreviewDelegate, savedImageOne:Image?, isFrontID:Bool, gender:String, jobTitle:String, religion:String, maritalStatus:String) {
        let viewModel = VerifyScanIDBackViewModel(coordinator: self, delegate: delegate, savedImageOne: savedImageOne, isFrontID: isFrontID, gender: gender, jobTitle: jobTitle, religion: religion, maritalStatus: maritalStatus)
        let view = VerifyScanIDBackScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openLivenessCheckScene() {
        let valifyUseCase = ValifyUseCase()
        let viewModel = LivenessCheckViewModel(coordinator: self, valifyUseCase: valifyUseCase)
        let view = LivenessCheckScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openLivenessScanScene(type: CameraPreviewType, savedImageOne:Image?, stepIndexBind:Int, isFrontBind:Bool) {
//        let viewModel = LivenessScanViewModel(coordinator: self)
        let kycUseCase = KYCUseCase()
        let valifyUseCase = ValifyUseCase()
        let viewModel = CameraPreviewViewModel(coordinator: self, kycUseCase: kycUseCase, valifyUseCase: valifyUseCase, viewType: type, savedImageOne: savedImageOne, stepIndexBind: stepIndexBind, isFrontBind: isFrontBind)
        let view = LivenessScanScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }


    func openQuestioneerScene() {
        let viewModel = QuestioneerViewModel(coordinator: self)
        let view = QuestioneerScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openTermsAndConditionsScene(){
        let kycUseCase = KYCUseCase()
        let viewModel = TermsAndConditionsViewModel(coordinator: self, KYCUseCase: kycUseCase)
        let view =   TermsAndConditionsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openThanksForRegisteringScene() {
        let viewModel = ThanksForRegisteringViewModel(coordinator: self)
        let view = ThanksForRegisteringScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openPinScene() {
        let useCase = AuthUseCase()
        let deviceConfigsUseCase = GetDeviceConfigsUseCase()
        let viewModel = PinViewModel(coordinator: self, useCase: useCase, getDeviceConfigsUseCase: deviceConfigsUseCase)
        let view = PinScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }


}
