//
//  AppValidation.swift
//  QSC
//
//  Created by FIT on 06/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode

class AppValidation{
    static let shared = AppValidation()
    //MARK: - phone number Validation
    func  phoneNumberValidate( _ text:String,countryUIModel:CountryFlagInfo) throws -> String {
        guard text.count == ValidationConstants.maxLength(.phoneNumber) else {
            throw ValidationConstants.ValidationType.phoneNumber
        }
        return text
    }


    //MARK: - Email Validation
    func  isEmail(_ email:String)throws -> String {
        let pattern = "[A-Z0-9a-z._%+-]{2,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        do {
            try checkPattern(value: email, pattern: pattern, error: ValidationConstants.ValidationType.email)

        }catch{
            throw error
        }

        return email
    }
    


    //MARK: - text Validation
    func  isTextValid(_ text: String)throws -> String {
        guard text.count >= 3 else {
            throw ValidationConstants.ValidationType.text
        }
        return text
    }
    //MARK: - password Validation
    func  isValidPassword(_ password: String) throws -> String {
        let pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
        do{
          try checkPattern(value: password, pattern: pattern, error: .password)
        }catch{
            throw error
        }
        return password
    }

    @discardableResult
    private func checkPattern(value:String,pattern:String,error:ValidationConstants.ValidationType,type:Int? = 0) throws -> String{

        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: value.count)
        let matches = regex?.matches(in: value, range: range) ?? []
        if !matches.isEmpty{
            return value
        }else{
            throw error
        }
    }
}
