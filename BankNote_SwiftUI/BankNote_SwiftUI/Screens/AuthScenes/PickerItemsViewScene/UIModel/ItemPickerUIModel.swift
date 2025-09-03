//
//  ItemPickerUIModel.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
protocol ItemPickerModelType{
    var key:String{get set}
    var id:String{get set}
    var name:String{get set}
    var subName:String{get set}
}
struct ItemPickerUIModel:ItemPickerModelType{
    var key:String = ""
    var name:String
    var subName:String = ""
    var id:String = UUID().uuidString
}
