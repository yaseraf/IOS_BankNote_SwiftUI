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
            .padding(.horizontal, 25)
            .frame(maxWidth: .infinity)
            .background(
                Color.white
                    .offset(y: 30)
//                    .shadow(radius: 3)
                    
            )
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
                            .frame(width: 71, height: 71)
                            .background(
                                Color(hex: "#EBEBEB")
                                    .frame(width: 70, height: 70)
                                    .clipShape(UpperHalfCircle())
                                    .offset(y: -6)
                            )
                        
                        
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
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().start()
        case .trade:
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().start()
        case .orders:
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getOrdersCoordinator().start()
        case .settings:
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getSettingsCoordinator().start()
        }

    }
}

// Custom shape for upper half-circle
struct UpperHalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .degrees(0),
                    endAngle: .degrees(180),
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    HomeBottomBarView(selectedItem: .settings)
}
