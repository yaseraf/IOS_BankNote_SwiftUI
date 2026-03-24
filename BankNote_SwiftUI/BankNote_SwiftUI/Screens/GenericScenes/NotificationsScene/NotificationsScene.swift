//
//  NotificationsScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/03/2026.
//

import SwiftUI
import Combine
struct NotificationsScene: BaseSceneType{
    @State var anyCancellable = Set<AnyCancellable>()

    @ObservedObject var viewModel: NotificationsViewModel

    @State var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    var body: some View {
        BaseScene(
            backgroundType: .colorBGSecondary,
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    backgroundType: .gradient,
                    content: {
                        NotificationsContentView(
                            notifications: $viewModel.notifications,
                            filteredOSSList: $viewModel.filterOSSList,
                            selectedTab: $viewModel.tabSelect,
                            onChangeTap: { tab in
                                viewModel.changeTap(tab: tab)
                            },
                            onBackTap: {
                                viewModel.popViewController()
                            }
                        )
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onAppear {
            
        }
        .onViewDidLoad{

        }
    }
    
 
    
}
