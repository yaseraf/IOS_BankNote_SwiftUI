//
//  PortfolioScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct PortfolioScene: BaseSceneType {
    @ObservedObject var viewModel: PortfolioViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                PortfolioContentView(portfoliosData: $viewModel.portfoliosData)
            })
            .onAppear {
                viewModel.getPortfolioData()
            }
        })
    }
}
