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
    
//    func openBoardingScene() {
//        let viewModel = BoardingViewModel(coordinator: self)
//        let view =   BoardingScene(viewModel: viewModel)
//        let viewWithCoordinator = view.withThemeEnvironment
//        let viewController = UIHostingController(rootView: viewWithCoordinator)
//        self.navigationController.pushViewController(viewController, animated: true)
//    }
    
//    func openCountiesScene(delegate: CountriesListDelegate,selectCountry:CountryFlagInfo?) {
//        let viewModel = CountriesListViewModel(coordinator:self,delegate: delegate, selectCountry: selectCountry)
//        let view =  CountriesListScene(viewModel: viewModel)
//        let viewWithCoordinator = view.withThemeEnvironment
//        let viewController = UIHostingController(rootView: viewWithCoordinator)
//        viewController.view.backgroundColor = .clear
//        viewController.modalPresentationStyle = .pageSheet
//        SceneDelegate.getAppCoordinator()?.topViewController()?.present(viewController, animated: true)
//    }

}
