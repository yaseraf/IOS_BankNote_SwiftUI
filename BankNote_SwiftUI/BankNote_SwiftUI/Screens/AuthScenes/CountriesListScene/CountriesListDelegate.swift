//
//  CountriesListDelegate.swift
//  mahfazati
//
//  Created by FIT on 02/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol CountriesListDelegate{
    func onSelect(model:CountryUIModel)
    func onSelectCountry(model:CountryFlagInfo)
}
