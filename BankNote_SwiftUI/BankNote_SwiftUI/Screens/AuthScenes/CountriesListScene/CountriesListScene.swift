//
//  CountriesListScene.swift
//  mahfazati
//
//  Created by Mohammmed on 02/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import SwiftUI
import Combine
import FlagAndCountryCode

struct CountriesListScene: View {
    @ObservedObject private var viewModel: CountriesListViewModel
    @State private var anyCancellable = Set<AnyCancellable>()
    @State private var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    @State  private var listCountries:[CountryFlagInfo] = []
    init(viewModel: CountriesListViewModel){
        self.viewModel = viewModel
    }

    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false,paddingValue:0,paddingVerticalValue: 0, backgroundType: .clear,content: {
                CountriesContentView(list: .constant(listCountries), selectModel: $viewModel.selectCountry, onTextChange: { text in
                    viewModel.searchOnCountryName(name: text)
                }, onTap: { model in
                    viewModel.selectCountry = model
                    viewModel.getDelegate().onSelectCountry(model: model)
                    viewModel.dissmiss()
                }, onCloseTap: {
                    viewModel.dissmiss()
                }, selectedSegment: $viewModel.selectedSegment)
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .background(Color.clear)
        .onViewDidLoad(){
            bindingAPI()
        }
        .onAppear(perform: {
            listCountries = CountryFlagInfo.all
//            viewModel.getCountries()
        })
        .ignoresSafeArea()

    }

    private func bindingAPI(){
        viewModel.$countriesAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
             break
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let response):
                listCountries = response

            case .none:
                break
            }

        }.store(in: &anyCancellable)

    }
}
