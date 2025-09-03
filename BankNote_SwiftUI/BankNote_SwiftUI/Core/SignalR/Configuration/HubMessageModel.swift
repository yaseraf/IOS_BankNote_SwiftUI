//
//  HubMessageModel.swift
//  QSC
//
//  Created by FIT on 01/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
struct HubResponseModel:Decodable{
    var data:DataMessageModel
}

struct DataMessageModel:Decodable{
    var hub:HubMessageModel
}

struct HubMessageModel:Decodable{
    var id:String
    var method:HubMethodType
    var arguments:Data?
}



