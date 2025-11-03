//
//  ValidationConstants.swift
//  QSC
//
//  Created by FIT on 06/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
struct ValidationConstants{

    enum ValidationType:LocalizedError {
        case phoneNumber
        case email
        case text
        case none
        case password

        var description:String{
            switch self {
            case .phoneNumber:
                return "enter_a_valid_mobile_number".localized
            case .email:
                return "email_is_not_valid".localized
            case.text:
                return "is_not_valid".localized
            case.password:
                return "password_is_not_valid".localized
            case.none:
                return ""
            }
        }
    }

    static func maxLength(_ validationType:ValidationType) ->Int?{
       return switch validationType {
        case .phoneNumber:
            10
        default:
            nil
        }
    }
}
