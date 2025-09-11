//
//  TransactionSuccessfulScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct TransactionSuccessfulScene: BaseSceneType {
    @ObservedObject var viewModel: TransactionSuccessfulViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                TransactionSuccessfulContentView(onBackToHomeTap: {
                    viewModel.popViewController()
                })
            })
        })
    }
}
