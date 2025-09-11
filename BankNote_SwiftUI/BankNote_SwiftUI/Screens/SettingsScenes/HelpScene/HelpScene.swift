//
//  HelpScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct HelpScene: BaseSceneType {
    @ObservedObject var viewModel: HelpViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                HelpContentView(onBackTap: {
                    viewModel.popViewController()
                })
            })
        })
    }
}
