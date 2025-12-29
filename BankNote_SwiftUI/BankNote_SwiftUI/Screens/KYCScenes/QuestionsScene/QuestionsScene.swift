//
//  LoginInformationScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct QuestionsScene: BaseSceneType {
    @ObservedObject var viewModel: QuestionsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                QuestionsContentView(questionsData: $viewModel.questionsData, onBack: {
                    viewModel.popViewController()
                }, onContinueTap: { answer, questionId in
                    viewModel.setAnswersValifyAPI(success: true, answer: answer, questionId: questionId)
                })
            })
            .onAppear {
                viewModel.getQuestionsValifyAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            getQuestionsValifyAPI()
            setAnswersValifyAPI()
        }
    }
    
    private func getQuestionsValifyAPI() {
        viewModel.$getQuestionsValifyAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
    private func setAnswersValifyAPI() {
        viewModel.$setAnswersValifyAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }

    
}
