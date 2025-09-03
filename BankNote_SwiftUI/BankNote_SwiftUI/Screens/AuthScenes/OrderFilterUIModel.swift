//
//  OrderFilterUIModel.swift
//  mahfazati
//
//  Created by Mohammmed on 23/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
struct OrderFilterUIModel{
    var id:String = UUID().uuidString
    var items:[OrderItemFilterUIModel]
    var category:OrderCategoryFilterUIModel
}

struct OrderItemFilterUIModel:Identifiable{
    var id:Int
    var name:String
    var key: String = ""

}
struct OrderCategoryFilterUIModel{
    var id:Int
    var name:String

}
