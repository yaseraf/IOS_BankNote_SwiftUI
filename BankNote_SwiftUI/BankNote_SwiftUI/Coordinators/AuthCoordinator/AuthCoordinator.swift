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
            openLoginScene()
        case .boarding:
            openLandingScene()
        case .register:
            openLoginScene()
        }
    }

    func restart() {
        start()
    }
    
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func openLoginScene() {
        let useCase = LoginUseCase()
        let viewModel = LoginViewModel(coordinator: self, useCase: useCase)
        let view = LoginScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openLandingScene() {
        let viewModel = LandingViewModel(coordinator: self)
        let view = LandingScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openCountryPickerScene() {
        let viewModel = CountryPickerViewModel(coordinator: self)
        let view = CountryPickerScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        self.navigationController.topViewController?.present(viewController, animated: true)
    }
    
    func openVerifyOtpScene(username: String, password: String) {
        let useCase = LoginUseCase()
        let viewModel = VerifyOtpPopupViewModel(coordinator: self, useCase: useCase, username: username, password: password)
        let view = VerifyOtpPopupScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .pageSheet
        viewController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.topViewController?.present(viewController, animated: true)
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
        let viewModel = SignUpViewModel(coordinator: self, verificationType: verificationType)
        let view = SignUpScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openVerifySignUpScene(verificationType: VerificationType, phone: String, email: String) {
        let viewModel = VerifySignUpViewModel(coordinator: self, verificationType: verificationType, phone: phone, email: email)
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

}
