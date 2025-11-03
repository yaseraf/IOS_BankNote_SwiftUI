//
//  VerifyOtpPopupScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ConfirmOtpPopupScene: BaseSceneType {
    @ObservedObject var viewModel: ConfirmOtpPopupViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue:0, paddingVerticalValue: 0, content: {
                ConfirmOtpPopupContentView(timerObserve: $viewModel.timerViewModel.timerObserve, onDismiss: {
                    viewModel.onDismiss()
                }, onResendOtpTap: {
                    viewModel.startTimer()
                }, onVerify: {
                    viewModel.onVerify()
                })
            })
        })
        .background(Color.clear)
        .ignoresSafeArea()
    }
}
