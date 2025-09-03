//
//  CustomTextFieldEnum.swift
//  QSC
//
//  Created by FIT on 06/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
enum TextFieldViewType{
    case name
    case email
    case phoneNumber
    case password
    case number
    case pinNumber
}

enum TextFieldStateType{
    case normal
    case active
    case error

    var borderColor:Color{
        get{
            switch self {
            case .normal:
                Color.colorBorderPrimary
            case .active:
                Color.colorPrimary
            case .error:
                Color.colorError

            }
        }
    }
}
