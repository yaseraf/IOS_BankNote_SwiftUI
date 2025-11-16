//
//  LoginInformationScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct LoginValifyScene: BaseSceneType {
    @ObservedObject var viewModel: LoginValifyViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                LoginValifyContentView(listPasswordValidation: $viewModel.listPasswordValidation, phone: $viewModel.phone, countryCodeUIModel: $viewModel.selectCountry, onPasswordTextChange: { text in
                    viewModel.checkValidation(text: text)
                    withAnimation{
                        viewModel.checkIsAllPasswordMatch()
                    }
                }, onCountryPickerTap: { countryData in
                    viewModel.openCountryPickerScene(countryModel: countryData)
                }, onContinueTap: { phone, password in
                    viewModel.loginValifyAPI(success: true, phone: phone, password: password)
                })
            })
            .onAppear {
                
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            LoginValifyAPI()
        }
    }
    
    private func LoginValifyAPI() {
        viewModel.$loginValifyAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
