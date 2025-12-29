//
//  LoginInformationViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import MapKit

class QuestionsViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: KYCUseCaseProtocol
    private let valifyUseCase: ValifyUseCaseProtocol

    @Published var getKYCCibcResponse: GetKYCCibcUIModel?
    @Published var stepCreateResponse: StepCreateUIModel?
    @Published var questionsData: GetQuestionsValifyUIModel?
//    @Published var listPasswordValidation: [PasswordValidationType:ChangePasswordUIModel] = [:]
    @Published var isAllPasswordMatch:Bool = false

    @Published var getKYCCibcAPIResult:APIResultType<GetKYCCibcUIModel>?
    @Published var stepCreateAPIResult:APIResultType<StepCreateUIModel>?
    @Published var registerValifyAPIResult:APIResultType<RegisterValifyUIModel>?
    @Published var csoValifyAPIResult:APIResultType<CsoValifyUIModel>?
    @Published var ntraValifyAPIResult:APIResultType<NtraValifyUIModel>?
    @Published var getQuestionsValifyAPIResult:APIResultType<GetQuestionsValifyUIModel>?
    @Published var setAnswersValifyAPIResult:APIResultType<SetAnswerValifyUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: KYCUseCaseProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.valifyUseCase = valifyUseCase
    }
}

// MARK: Routing
extension QuestionsViewModel {
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
    
    func openSetPasswordScene() {
        coordinator.openSetPasswordScene()
    }
}

// MARK: API Calls
extension QuestionsViewModel {
    
    // MARK: Valify
    func getQuestionsValifyAPI(success: Bool) {
        
        let requestModel = GetQuestionsValifyRequestModel(reqID: KeyChainController().valifyRequestId ?? "")
        
        getQuestionsValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.GetQuestionsValify(requestModel: requestModel) {[weak self] result in
                self?.getQuestionsValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getQuestionsValifyAPIResult = .onSuccess(response: success)
                    debugPrint("get questions success")
                    self?.questionsData = success
                    
                case .failure(let failure):
                        debugPrint("get questions failed")
                        self?.getQuestionsValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
    
    func setAnswersValifyAPI(success: Bool, answer: String, questionId: String) {
        
        let requestModel = SetAnswerValifyRequestModel(
            answer: answer,
            lang: AppUtility.shared.isRTL ? "ar" : "en",
            questionId: questionId,
            accessToken: KeyChainController().valifyAccessToken ?? "",
            reqID: KeyChainController().valifyRequestId ?? ""
        )
                                                       
        setAnswersValifyAPIResult = .onLoading(show: true)

        Task.init {
            await valifyUseCase.SetAnswerValify(requestModel: requestModel) {[weak self] result in
                self?.setAnswersValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.setAnswersValifyAPIResult = .onSuccess(response: success)
                    
                    if success.isSuccessful == true {
                        debugPrint("set password success")
                        self?.openSetPasswordScene()
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, success.serverResponse ?? "")
                    }
                    
                case .failure(let failure):
                        debugPrint("set password failed")
                        self?.setAnswersValifyAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
}

// MARK: Functions
extension QuestionsViewModel {

}
