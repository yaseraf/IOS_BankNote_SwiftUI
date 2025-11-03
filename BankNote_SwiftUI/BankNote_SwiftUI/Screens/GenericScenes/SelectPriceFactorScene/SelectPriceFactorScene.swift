//
//  SelectPriceFactorScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct SelectPriceFactorScene: BaseSceneType {
    @ObservedObject var viewModel: SelectPriceFactorViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SelectPriceFactorContentView(priceFactors: $viewModel.priceFactors, onDismiss: {
                    viewModel.onDismiss()
                }, onConfirm: { factor in
                    viewModel.onConfirm(factor: factor)
                })
            })
        })
    }
}
