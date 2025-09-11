//
//  IndexScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct IndexScene: BaseSceneType {
    @ObservedObject var viewModel: IndexViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                IndexContentView(indexData: $viewModel.indexData, onBackTap: {
                    viewModel.popViewController()
                })
                .onAppear {
                    viewModel.getIndexData()
                }
            })
           
        })
    }
}
