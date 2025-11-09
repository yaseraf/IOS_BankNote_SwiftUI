//
//  LivenessCheckScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct LivenessCheckScene: BaseSceneType {
    @ObservedObject var viewModel: LivenessCheckViewModel
    @State private var presentingVC: UIViewController?
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                LivenessCheckContentView(onContinueTap: {
//                    viewModel.openLivenessScanScene()
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            startLiveness()
        }
    }
    
    private func startLiveness() {
        viewModel.$startLivenessAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
