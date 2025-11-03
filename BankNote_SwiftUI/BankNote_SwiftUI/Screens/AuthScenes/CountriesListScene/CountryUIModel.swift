//
//  CountryUIModel.swift
//  mahfazati
//
//  Created by FIT on 02/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
struct CountryUIModel{
    var id:Int

    var name:String
    var iconName:String
    var mcc:String
    var mccWithPlus:String{
        get{
            "\(mcc)"
        }
    }
//    var mccWithPlus:String{
//        get{
//            "+\(mcc)"
//        }
//    }

}

