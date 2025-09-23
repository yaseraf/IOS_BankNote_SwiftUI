//
//  CountriesListDelegate.swift
//  mahfazati
//
//  Created by Mohammmed on 02/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import FlagAndCountryCode

protocol CountriesListDelegate{
    func onSelect(model:CountryUIModel)
    func onSelectCountry(model:CountryFlagInfo)
}
