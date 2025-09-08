//
//  CountryPickerScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct CountryPickerScene: BaseSceneType {
    @ObservedObject var viewModel: CountryPickerViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false,paddingValue:0,paddingVerticalValue: 0, backgroundType: .clear,content: {
                CountryPickerContentView()
            })
        })
        .background(Color.clear)
        .ignoresSafeArea()
    }
}
