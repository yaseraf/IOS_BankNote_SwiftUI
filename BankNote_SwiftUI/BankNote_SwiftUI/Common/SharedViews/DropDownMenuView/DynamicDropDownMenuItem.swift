//
//  DynamicDropDownMenuItem.swift
//  QSC
//
//  Created by FIT on 23/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct  DynamicDropDownMenuItem: View {

    var buttonHeight: CGFloat  =  54
    var maxItemDisplayed: Int  =  3
    @State  var showDropdown: Bool = false
    var placeHolder:String
    @Binding  var selectedOptions:[ItemPickerModelType]
    var onTap:(()->Void)


    var body: some  View {

        //            ZStack() {


        // selected item
        Button(action: {
            withAnimation {
                showDropdown.toggle()
            }
            onTap()
        }, label: {
            HStack(spacing: nil) {
                ZStack(alignment: .leading){
                    Text(placeHolder)
//                        .foregroundStyle(selectedOptions.isEmpty ? Color.colorTextPlaceHolder : Color.colorTextPrimary  )
                        .foregroundStyle(Color.colorTextPlaceHolder  )
                        .font(.apply(size:selectedOptions.isEmpty ? 17 : 12))
                        .offset(y: selectedOptions.isEmpty ? 0 : -25)
                        .scaleEffect( selectedOptions.isEmpty ?  1: 0.75, anchor: .leading)

                    if !selectedOptions.isEmpty{
                        drawItems()
                    }

                }
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                    .tint(Color.colorTextPlaceHolder)
            }
        })

        .padding(.horizontal, 20)
        .frame(maxWidth:.infinity)
        .frame(height:buttonHeight)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.colorBorderPrimary, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.colorBGTertiary)
        )

    }


    func drawItems() -> some View{

        ScrollView(.horizontal){
            LazyHStack(spacing:2){
                ForEach(Array($selectedOptions.wrappedValue.enumerated()), id: \.offset) { index, element in

                    cellItem(item: element)
                }
            }
        }

    }
    private func cellItem(item:ItemPickerModelType) -> some View {

        return HStack{
            Text(item.name)
                .foregroundStyle(Color.colorLink)
                .font(.apply(size: 11))
                .padding(.horizontal,6)
                .padding(.vertical,2)
                .background(
                    RoundedRectangle(cornerRadius: 99)
                        .fill(Color.colorBrand)
                )

                .background(
                    RoundedRectangle(cornerRadius: 99)
                        .stroke(Color.colorLink, lineWidth: 1)
                )
        }

    }
}

