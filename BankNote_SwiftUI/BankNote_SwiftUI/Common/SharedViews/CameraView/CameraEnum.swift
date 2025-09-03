//
//  CameraEnum.swift
//  QSC
//
//  Created by FIT on 09/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum CameraPreviewType: Equatable {
    case selfieMode(liveness:Bool)
    case scanMode(UserIDType)
}
