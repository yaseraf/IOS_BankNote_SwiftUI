//
//  SignOutPopupViewModel.swift
//  mahfazati
//
//  Created by Mohammmed on 05/09/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

class SignOutPopupViewModel:ObservableObject{
//    private let coordinator:ManageCoordinatorProtocol
    private let usersLogOffUseCase: UsersLogOffUseCaseProtocol

    @Published var usersLogOffAPIResult:APIResultType<UsersLogOffUIModel>?

//    init(coordinator: ManageCoordinatorProtocol, usersLogOffUseCase: UsersLogOffUseCaseProtocol) {
//        self.coordinator = coordinator
//        self.usersLogOffUseCase = usersLogOffUseCase
//
//    }
    
    init(usersLogOffUseCase: UsersLogOffUseCaseProtocol, usersLogOffAPIResult: APIResultType<UsersLogOffUIModel>? = nil) {
        self.usersLogOffUseCase = usersLogOffUseCase
        self.usersLogOffAPIResult = usersLogOffAPIResult
    }
    
    private func disconnectSignalR() {
        if !Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.connection?.stop()
        }
    }
    
    func UsersLogOffAPI(success:Bool) {
        let requestModel = UsersLogOffRequestModel()
        usersLogOffAPIResult = .onLoading(show: true)
        
        Task.init {
            await usersLogOffUseCase.UsersLogOff(requestModel: requestModel) {[weak self] result in
                self?.usersLogOffAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.usersLogOffAPIResult = .onSuccess(response: success)
                    UserDefaultController().isLoggedIn = false
                    UserDefaultController().selectedUserAccount = nil
                    debugPrint("Logoff success")
                    
                    self?.disconnectSignalR()
                    
                    self?.signOut()
                    
                case .failure(let failure):
                        self?.usersLogOffAPIResult = .onFailure(error: failure)
                    debugPrint("Logoff fail")
                }
            }
        }
    }

    func signOut(){
        UserDefaultController().isAutoLogin = false
//        coordinator.dismiss(complete: {
//            SceneDelegate.getAppCoordinator()?.logout()
//        })

    }
}
extension SignOutPopupViewModel{
//    func dismiss() {
//        coordinator.dismiss()
//    }


}
