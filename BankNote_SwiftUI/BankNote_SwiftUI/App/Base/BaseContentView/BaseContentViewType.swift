//
//  BaseScene.swift
//  QSC
//
//  Created by FIT on 23/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

protocol BaseContentViewType {
}

protocol BaseSceneViewType {
    var showLoading: Bool {get set }
}

struct DefaultBaseSceneViewType: BaseSceneViewType{
    var showLoading: Bool = false
}

extension BaseContentViewType{
    var onBack: (() -> Void)?  {
        get {return nil}
        set{ }
    }

    var onDismiss: (() -> Void)?  {
        get {return nil}
        set{ }
    }
}

