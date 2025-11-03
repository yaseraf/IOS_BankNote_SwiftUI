//
//  TiersScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct TiersScene: BaseSceneType {
    @ObservedObject var viewModel: TiersViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                TiersContentView(onBackTap: {
                    viewModel.popViewController()
                })
            })
        })
    }
}
