//
//  CustomTabsView.swift
//  QSC
//
//  Created by FIT on 26/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct CustomTabsView: View {
    enum SelectType{
        case left
        case right
    }
    var selectType:Binding<SelectType>
    var leftTitle:String
    var onLeftTap:(()->Void)
    var rightTitle:String
    var onRightTap:(()->Void)

    var body: some View {
        HStack{
            getItemView(type: .left)
            .onTapGesture {
                onLeftTap()
            }
            getItemView(type: .right)
                .onTapGesture {
                    onRightTap()
                }
        }
        .padding(.vertical,2)
        .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(getBackgroundFillColor())
        )
    }

    func getItemView(type:SelectType) ->some View{

        HStack{
            Text(type == .left ?  leftTitle : rightTitle)
                .font(Font.apply(.medium,size: 13))
                .foregroundStyle(Color.colorTextPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical,5)
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(selectType.wrappedValue == type ?  getFillColor() : Color.clear)
                )
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(selectType.wrappedValue == type ?  Color.colorBorderPrimary : Color.clear,lineWidth: 1)
                )
                .shadow(color:selectType.wrappedValue == type ?  Color.black.opacity(0.2) : Color.clear,radius: 5,x: 1,y: 1)
        }

    }

    private func getFillColor() -> Color{
        AppUtility.shared.isDarkTheme ? Color.colorQuaternary : Color.colorBGPrimary
    }

    private func getBackgroundFillColor() -> Color{
        AppUtility.shared.isDarkTheme ? Color.colorBGTertiary : Color.colorQuaternary
    }

}

#Preview {
    CustomTabsView(selectType: .constant(.right), leftTitle: "leftTitle", onLeftTap: {}, rightTitle: "rightTitle" , onRightTap: {})

}
