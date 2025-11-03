//
//  ChooseNationalityScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct ChooseNationalityScene: BaseSceneType {
    @ObservedObject var viewModel: ChooseNationalityViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                ChooseNationalityContentView(selectedNationalityItemPicker: $viewModel.selectNationalityItemPicker, onNationalityTap: {
                    viewModel.openPickerNationality()
                }, onContinueTap: { nationalityInput in
                    viewModel.getKYCCibcAPI(success: true, requestItems: [GetKYCCibcRequestItems(ID: "18", Value: "0"), GetKYCCibcRequestItems(ID: "7", Value: nationalityInput)])
                })
            })
            .onAppear {
                viewModel.getNationalityAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            NationalityAPI()
            getKYCCibcAPI()
        }
    }
    
    private func NationalityAPI() {
        viewModel.$getNationalityAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getKYCCibcAPI() {
        viewModel.$getKYCCibcAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
