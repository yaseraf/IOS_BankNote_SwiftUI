//
//  HomeBottomBarView.swift
//  QSC
//
//  Created by FIT on 16/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct HomeBottomBarView: View {
   var refresh:Binding<Bool>?

    @State var selectedItem:HomeTabBarItem
    init(selectedItem: HomeTabBarItem,refresh:Binding<Bool>? = nil ) {
        self.selectedItem = selectedItem
        self.refresh = refresh
    }
    var body: some View {

        HStack{
            getItemView(item: .pricing)
            Spacer()
            getItemView(item: .portfolio)
            Spacer()
            getItemView(item: .orders)
            Spacer()
            getItemView(item: .favourite)
            Spacer()
            getItemView(item: .menu)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.colorBGThird)

    }

    func getItemView(item:HomeTabBarItem) -> some View {

            Button {
                actionTapBarITem(item: item)
            } label: {
                VStack(spacing: 6){
                    Color.colorPrimary
                        .frame(height: 2)
                        .opacity(selectedItem == item ? 1 : 0)

                    Image(item.iconName)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24)
                        .frame(height: 24)
                        .foregroundStyle(selectedItem == item ? Color.colorPrimary : Color.colorFGQuaternary)

                    Text(item.title)
                        .foregroundStyle(selectedItem == item ? Color.colorPrimary : Color.colorTextDisable)
                        .font(.apply(selectedItem == item  ? .bold : .regular,size: 12))
                }
            }
            .disabled(selectedItem == item)
    }

    func actionTapBarITem(item:HomeTabBarItem){
        switch item {
        case .pricing:
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().start()
        case .portfolio:
            debugPrint("")
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().start()
        case .orders:
            debugPrint("")
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().start()
        case .favourite:
            debugPrint("")
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getFavoriteCoordinator().start()
        case .menu:
            debugPrint("")
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getManageCoordinator().start()
        }

    }
}

#Preview {
    HomeBottomBarView(selectedItem: .pricing)
}
