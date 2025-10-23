//
//  AppCoordinator.swift
//  mahfazati
//
//  Created by Mohammmed on 22/07/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI

class AppCoordinator:  ObservableObject {

    var navigationController: BaseNavigationController
    var childCoordinator: [Coordinator] = []
    private let window: UIWindow

    var currentHomeCoordinator:HomeCoordinator? {
        get{
           SceneDelegate.getAppCoordinator()?.getChildCoordinator(coordinator: HomeCoordinator.self) as? HomeCoordinator
        }
    }


    init(window: UIWindow) {
        self.window = window
        navigationController = BaseNavigationController()
        self.window.rootViewController = navigationController
    }

    func start() {
        SceneDelegate.getAppCoordinator()?.updateWindowBackground()
        openSplashScene()
    }

    func logout(){
        // clear data
        childCoordinator.removeAll()
        navigationController.viewControllers = []
        startFlow(startWith: .login)

    }

    func getWindow() -> UIWindow {
        return window
    }


    func updateWindowBackground() {
        window.backgroundColor = UIColor(Color.colorBG)
    }

    func showViewWithAnimation(dvc: UIViewController) {
        window.rootViewController = dvc
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.4
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: { _ in
        })
    }

    func restart() {
        childCoordinator.last?.start()
        AppUtility.shared.animateScene()
    }
    
    func restartForTheme() {
        SceneDelegate.getAppCoordinator()?.topViewController()?.dismiss(animated: false, completion: nil)
        childCoordinator.last?.start()
        debugPrint("Restarting scene")
        AppUtility.shared.animateScene()
    }


    func restartLanguageUpdate() {
//        currentHomeCoordinator?.getManageCoordinator().restart()
    }

    var isUserLoggedIn:Bool {
        get{
            let  childCoordinator = self.getChildCoordinator(coordinator: AuthCoordinator.self) as? AuthCoordinator
            return childCoordinator == nil
        }
    }

    func topViewController() -> UIViewController?{
        guard let viewController = self.navigationController.viewControllers.last else{return nil}

        guard let presentedViewController = viewController.presentedViewController else{
            return tabBarChildViewController(currentViewController: viewController)
        }
        return tabBarChildViewController(currentViewController: presentedViewController) 


        func tabBarChildViewController(currentViewController:UIViewController)->UIViewController?{
            if let viewController = currentViewController.presentedViewController{
                if let   viewController =  viewController.presentedViewController{
                    return viewController
                }
                return viewController

            }

            return currentViewController
        }
    }

    public func showMessage(type: MessageViewType = .success, _ message: String) {
        MessageViewController.instance.show(type, text: message)
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func startFlow(startWith: AuthCoordinator.AuthStartSceneType) {
        let authCoordinator:AuthCoordinator
        if let childCoordinator = self.getChildCoordinator(coordinator: AuthCoordinator.self) as? AuthCoordinator {
            authCoordinator = childCoordinator
            authCoordinator.updateStartViewType(startWith)
        }else{
            childCoordinator.removeAll()
            authCoordinator =  .init(navigationController: navigationController, startViewType: startWith)
            childCoordinator.append(authCoordinator)
            authCoordinator.updateStartViewType(startWith)
        }
        authCoordinator.start()
    }
    
    func showHomeFlow() {
        removeAllChildCoordinator()

        let  homeCoordinator:HomeCoordinator
        if let  childCoordinator = self.getChildCoordinator(coordinator: HomeCoordinator.self) as? HomeCoordinator {
            homeCoordinator = childCoordinator
        }else{
            childCoordinator.removeAll()
            homeCoordinator =  .init(navigationController: navigationController)
            childCoordinator.append(homeCoordinator)
        }
        homeCoordinator.start()
    }

    func removeAllChildCoordinator(){
        for coordinator in self.childCoordinator {
            for childCoordinator in coordinator.childCoordinator {
                childCoordinator.childCoordinator = []
            }
            coordinator.childCoordinator = []
        }
        childCoordinator = []
    }
    
    func openSplashScene() {
        let viewModel = SplashViewModel(coordinator: self)
        let view =  SplashScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openPickerItemsScene(allowSearch:Bool, tag:Int,title:String,delegate: PickerItemsDelegate,selectItem:ItemPickerModelType?,list:[ItemPickerModelType]) {
        let viewModel = PickerItemsViewModel(allowSearch: allowSearch, selectType: .one,tag:tag,title:title,delegate: delegate, selectItem: selectItem, list: list)
        let view =  PickerItemsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .overFullScreen
        SceneDelegate.getAppCoordinator()?.topViewController()?.present(viewController, animated: true)
    }

    func openPickerMultiItemsScene(tag:Int,title:String,delegate: PickerItemsDelegate,selectItems:[ItemPickerModelType],list:[ItemPickerModelType], mandatoryFields: [ItemPickerModelType] = []) {
        let viewModel = PickerItemsViewModel(allowSearch: true, selectType: .multi,tag:tag,title:title,delegate: delegate, selectItem: nil,selectItems:selectItems, list: list, mandatoryFields: mandatoryFields)
        let view =  PickerItemsScene(viewModel: viewModel)
        let viewWithCoordinator = view.withThemeEnvironment
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        viewController.view.backgroundColor = .clear
        viewController.modalPresentationStyle = .overFullScreen
        SceneDelegate.getAppCoordinator()?.topViewController()?.present(viewController, animated: true)
    }

}


