//
//  NewsScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct NewsScene: BaseSceneType {
    @ObservedObject var viewModel: NewsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                NewsContentView(newsData: $viewModel.newsData, onBackTap: {
                    viewModel.popViewController()
                })
                .onAppear {
                    viewModel.getNewsData()
                }
            })
        })
    }
}
