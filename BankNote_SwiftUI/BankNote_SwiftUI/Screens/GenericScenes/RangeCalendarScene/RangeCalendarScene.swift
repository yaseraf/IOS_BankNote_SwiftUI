//
//  RangeCalendarScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct RangeCalendarScene: BaseSceneType {
    @ObservedObject var viewModel: RangeCalendarViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                RangeCalendarContentView(title: $viewModel.title, selectedDateFrom: $viewModel.selectedDateFrom, selectedDateTo: $viewModel.selectedDateTo, isMultiSelect: $viewModel.isMultiSelect, onDismiss: {
                    viewModel.onDismissTap()
                }, onConfirm: {
                    viewModel.onConfirmTap()
                })
            })
        })
    }
}
