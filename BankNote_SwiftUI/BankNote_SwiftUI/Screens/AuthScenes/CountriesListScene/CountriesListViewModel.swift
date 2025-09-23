//
//  CountriesListViewModel.swift
//  mahfazati
//
//  Created by Mohammmed on 02/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import FlagAndCountryCode

class CountriesListViewModel:ObservableObject{
    private let coordinator:Coordinator
    private let delegate:CountriesListDelegate
    @Published var selectCountry:CountryFlagInfo?

    @Published var countriesAPIResult:APIResultType<[CountryFlagInfo]>?
    @Published var selectedSegment: Int = 0
    private var listAllCountries = [CountryUIModel]()

    init(coordinator:Coordinator,delegate: CountriesListDelegate,selectCountry:CountryFlagInfo?) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.selectCountry = selectCountry
    }



    func getDelegate()-> CountriesListDelegate {
        return delegate
    }


//    func getCountries() {
//        countriesAPIResult = .onLoading(show: true)
//        let countries = CountryFlagInfo.all
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1){[weak self] in
//            var list:[CountryUIModel] = []
//            for i in 0..<countries.count{
//                let id = i + 1
//                let countryUIModel = CountryUIModel(id: id, name: countries[i].name, iconName: "flag\(3)", mcc: countries[i].dialCode)
//                list.append(countryUIModel)
//            }
//            self?.countriesAPIResult = .onLoading(show: false)
//            self?.listAllCountries = list
//            self?.countriesAPIResult = .onSuccess(response: list)
//        }
//    }


    func searchOnCountryName(name:String) {
       var filteredList = CountryFlagInfo.all.filter({
           $0.name.localized.lowercased().contains(name.localized.lowercased())
        })
        if filteredList.isEmpty{
            filteredList = CountryFlagInfo.all
        }

        self.countriesAPIResult = .onSuccess(response: filteredList)
    }
}

extension CountriesListViewModel{
    func dissmiss() {
        coordinator.dismiss(animated: true)
    }
}
