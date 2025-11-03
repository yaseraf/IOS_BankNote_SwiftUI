//
//  HomeOrderHeaderView.swift
//  QSC
//
//  Created by FIT on 18/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
struct HomeOrderHeaderView <Content: View>: View{
    var isTransactionScene:Bool
    var titleScreen:String
    var isOrdersScreen: Bool
    var isEditOrder: Bool
    let rightView:  Content
    var onSwitchPortfolioTap:(()->Void)
    var onCloseTap:(()->Void)
   var selectGetUserAccountsUIModel:Binding<GetUserAccountsUIModel>?

    init(isTransactionScene:Bool ,titleScreen: String, isOrdersScreen:Bool, isEditOrder:Bool, @ViewBuilder  rightView:  ()-> Content ,selectGetUserAccountsUIModel:Binding<GetUserAccountsUIModel>, onSwitchPortfolioTap:@escaping(()->Void), onCloseTap:@escaping (()->Void)) {
        self.isTransactionScene = isTransactionScene
        self.titleScreen = titleScreen
        self.isOrdersScreen = isOrdersScreen
        self.isEditOrder = isEditOrder
        self.rightView = rightView()
        self.onSwitchPortfolioTap = onSwitchPortfolioTap
        self.selectGetUserAccountsUIModel = selectGetUserAccountsUIModel
        self.onCloseTap = onCloseTap
    }
        
    var body: some View {
        HStack{
            if !isOrdersScreen {
                leftView
            }
            Spacer()
            Button {
                onSwitchPortfolioTap()
            }
            label: {
                if !isTransactionScene {
                    centerView
                }
            }
            .disabled(isEditOrder)
//            .opacity(isEditOrder ? 0.5 : 1)


            Spacer()
            rightView
        }.frame(maxWidth: .infinity)
    }

    var leftView:some View {
        Button {
            onCloseTap()
            //SceneDelegate.getAppCoordinator()?.popViewController()
        } label: {
            BackCustomView()
        }
    }

    var centerView:some View{
        VStack(alignment: .center,spacing: 0){
            Text(titleScreen)
                .font(.apply(.semiBold,size:17))
                .foregroundStyle(Color.colorTextPrimary)
            if let selectGetUserAccountsUIModel = selectGetUserAccountsUIModel?.wrappedValue {
                HStack(spacing:2){

                    Text(selectGetUserAccountsUIModel.ClientNameA ?? "no client name")
                        .font(.apply(size:13))
                        .foregroundStyle(Color.colorTextTertiary)

                    Image("ic_downArrow").resizable()
                        .renderingMode(.template)
                        .frame(width: 16)
                        .frame(height:  16)
                        .foregroundStyle(Color.colorFGPrimary)

              }
            }

        }

    }

}

//#Preview {
//    HomeOrderHeaderView(titleScreen: "Order", rightView: {Text("A")}, selectGetUserAccountsUIModel: .constant(GetUserAccountsUIModel(accountType: "", clientNameA: "", clientNameE: "", clientID: "", mainClientID: "", currency: "")), onSwitchPortfolioTap: {}, onCloseTap: {})
//}
