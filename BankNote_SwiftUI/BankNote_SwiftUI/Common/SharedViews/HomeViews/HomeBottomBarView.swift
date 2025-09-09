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

        ZStack {
            Image(
                selectedItem == .home ? "homeSubtract" :
                    selectedItem == .portfolio ? "portfolioSubtract" : selectedItem == .trade ? "tradeSubtract" : selectedItem == .orders ? "ordersSubtract" : "settingsSubtract"
            )
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)

            HStack(alignment: .bottom, spacing: 0){
                getItemView(item: .home)
                Spacer()
                getItemView(item: .portfolio)
                Spacer()
                getItemView(item: .trade)
                Spacer()
                getItemView(item: .orders)
                Spacer()
                getItemView(item: .settings)
            }
            .padding(.horizontal, selectedItem == .home ? 15 : selectedItem == .portfolio ? 37 : 0)
            .padding(.bottom, 35)
            .frame(maxWidth: .infinity)
//            .background(.white)
            
//            VStack(spacing: 0) {
//                Spacer()
//                Color.red
//                    .ignoresSafeArea()
//                    .frame(height: 33)
//            }
        }
    }

    func getItemView(item:HomeTabBarItem) -> some View {

            Button {
                actionTapBarITem(item: item)
            } label: {
                VStack(alignment: .center, spacing: 0){
                    if selectedItem == item {
                        
                        Image(selectedItem == .home ? "ic_homeSelected" : selectedItem == .portfolio ? "ic_portfolioSelected" : selectedItem == .trade ? "ic_tradeSelected" : selectedItem == .orders ? "ic_ordersSelected" : selectedItem == .settings ? "ic_settingsSelected" : "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            
                        
                    } else {
                        Image(item.iconName)
                            .resizable()
                            .frame(width: 24)
                            .frame(height: 24)

                    }
                    
                    Text(item.title)
                        .foregroundStyle(selectedItem == item ? Color(hex: "#9C4EF7") : Color(hex: "#1C1C1C"))
                        .font(.cairoFont(.semiBold, size: selectedItem == item ? 14 : 12))
                    
                    
                }
            }
            .disabled(selectedItem == item)
    }

    func actionTapBarITem(item:HomeTabBarItem){
        switch item {
        case .home:
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().start()
        case .portfolio:
            debugPrint("")
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().start()
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().start()
        case .trade:
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().start()

            debugPrint("")
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().start()
        case .orders:
            debugPrint("")
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getFavoriteCoordinator().start()
        case .settings:
            debugPrint("")
//            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getManageCoordinator().start()
        }

    }
}

#Preview {
    HomeBottomBarView(selectedItem: .trade)
}
