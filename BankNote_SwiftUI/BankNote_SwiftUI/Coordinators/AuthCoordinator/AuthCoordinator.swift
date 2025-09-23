//
//  AuthCoordinator.swift
//  mahfazati
//
//  Created by Mohammmed on 22/07/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode



class AuthCoordinator:  ObservableObject {
    enum AuthStartSceneType{
        case login
        case boarding
        case register
    }
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
    
    func openSignUpScene(verificationType: VerificationType) {
        let useCase = KYCUseCase()
        let viewModel = SignUpViewModel(coordinator: self, useCase: useCase, verificationType: verificationType)
        let view = SignUpScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openVerifySignUpScene(verificationType: VerificationType, phone: String, email: String, otpExpirationTimer: Double, otpRequestID: String, transactionID: String, requestIDVlens: String, isVlens: Bool) {
        let useCase = KYCUseCase()
        let viewModel = VerifySignUpViewModel(coordinator: self, useCase: useCase, verificationType: verificationType, phone: phone, email: email, otpExpirationTimer: otpExpirationTimer, timerViewModel: .init(), otpRequestID: otpRequestID, transactionID: transactionID, requestIDVlens: requestIDVlens, isVlens: isVlens)
        let view = VerifySignUpScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openChooseNationalityScene() {
        let viewModel = ChooseNationalityViewModel(coordinator: self)
        let view = ChooseNationalityScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openLoginInformationScene() {
        let viewModel = LoginInformationViewModel(coordinator: self)
        let view = LoginInformationScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openScanIDFrontScene() {
        let viewModel = ScanIDFrontViewModel(coordinator: self)
        let view = ScanIDFrontScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openVerifyScanIDFrontScene() {
        let viewModel = VerifyScanIDFrontViewModel(coordinator: self)
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
    
    func openVerifyScanIDBackScene() {
        let viewModel = VerifyScanIDBackViewModel(coordinator: self)
        let view = VerifyScanIDBackScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func openLivenessCheckScene() {
        let viewModel = LivenessCheckViewModel(coordinator: self)
        let view = LivenessCheckScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openLivenessScanScene() {
        let viewModel = LivenessScanViewModel(coordinator: self)
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
