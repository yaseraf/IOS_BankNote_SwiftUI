//
//  Custom3TabsView.swift
//  QSC
//
//  Created by FIT on 05/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct Custom3TabsView: View {
    enum SelectType{
        case left
        case right
        case centre
    }
    var selectType:Binding<SelectType>
    var leftTitle:String
    var onLeftTap:(()->Void)
    var centreTitle:String
    var onCentreTap:(()->Void)
    var rightTitle:String
    var onRightTap:(()->Void)

    var body: some View {
        HStack{
            getItemView(type: .left)
            .onTapGesture {
                onLeftTap()
            }

            getItemView(type: .centre)
                .onTapGesture {
                    onCentreTap()
                }
            getItemView(type: .right)
                .onTapGesture {
                    onRightTap()
                }
        }
        .padding(.vertical,2)
        .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color.colorQuaternary)
        )
    }

    func getItemView(type:SelectType) ->some View{

        HStack{
            Text(getTitle(type:type))
                .font(Font.apply(.medium,size: 13))
                .foregroundStyle(Color.colorTextPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical,5)
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(selectType.wrappedValue == type ?  Color.colorBGPrimary : Color.clear)
                )
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(selectType.wrappedValue == type ?  Color.colorBorderPrimary : Color.clear,lineWidth: 1)
                )
                .shadow(color:selectType.wrappedValue == type ?  Color.black.opacity(0.2) : Color.clear,radius: 5,x: 1,y: 1)
        }

    }

    private func getTitle(type:SelectType) -> String{
        switch type{

        case .left:
            leftTitle
        case .right:
            rightTitle
        case .centre:
            centreTitle
        }
    }


}

struct Custom4TabsView: View {
    enum SelectType{
        case first
        case second
        case third
        case forth
    }
    var selectType:Binding<SelectType>
    var firstTitle:String
    var onFirstTabTap:(()->Void)
    var secondTitle:String
    var onSecondTabTap:(()->Void)
    var thirdTitle:String
    var onThirdTabTap:(()->Void)
    var forthTitle:String
    var onForthTabTap:(()->Void)

    var body: some View {
        HStack{
            getItemView(type: .first)
            .onTapGesture {
                onFirstTabTap()
            }

            getItemView(type: .second)
                .onTapGesture {
                    onSecondTabTap()
                }
            getItemView(type: .third)
                .onTapGesture {
                    onThirdTabTap()
                }
            getItemView(type: .forth)
                .onTapGesture {
                    onForthTabTap()
                }
        }
        .padding(.vertical,2)
        .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color.colorQuaternary)
        )
    }

    func getItemView(type:SelectType) ->some View{

        HStack{
            Text(getTitle(type:type))
                .font(Font.apply(.medium,size: 13))
                .foregroundStyle(Color.colorTextPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical,5)
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(selectType.wrappedValue == type ?  Color.colorBGPrimary : Color.clear)
                )
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(selectType.wrappedValue == type ?  Color.colorBorderPrimary : Color.clear,lineWidth: 1)
                )
                .shadow(color:selectType.wrappedValue == type ?  Color.black.opacity(0.2) : Color.clear,radius: 5,x: 1,y: 1)
        }

    }

    private func getTitle(type:SelectType) -> String{
        switch type{

        case .first:
            firstTitle
        case .second:
            secondTitle
        case .third:
            thirdTitle
        case .forth:
            forthTitle
        }
    }


}

struct Custom2TabsView: View {
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
                    .fill(Color.colorQuaternary)
        )
    }

    func getItemView(type:SelectType) ->some View{

        HStack{
            Text(getTitle(type:type))
                .font(Font.apply(.medium,size: 13))
                .foregroundStyle(Color.colorTextPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical,5)
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(selectType.wrappedValue == type ?  Color.colorBGPrimary : Color.clear)
                )
                .background(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(selectType.wrappedValue == type ?  Color.colorBorderPrimary : Color.clear,lineWidth: 1)
                )
                .shadow(color:selectType.wrappedValue == type ?  Color.black.opacity(0.2) : Color.clear,radius: 5,x: 1,y: 1)
        }

    }

    private func getTitle(type:SelectType) -> String{
        switch type{
        case .left:
            leftTitle
        case .right:
            rightTitle
        }
    }


}



#Preview {
    Custom3TabsView(selectType: .constant(.right), leftTitle: "leftTitle", onLeftTap: {}, centreTitle: "centreTitle",onCentreTap: {},rightTitle: "rightTitle" , onRightTap: {})

}
