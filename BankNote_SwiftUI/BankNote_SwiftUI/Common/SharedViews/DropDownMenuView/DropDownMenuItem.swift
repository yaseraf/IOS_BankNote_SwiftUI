//
//  DropDownMenuView.swift
//  QSC
//
//  Created by FIT on 08/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct  DropDownMenuItem: View {

    var buttonHeight: CGFloat  =  54
    var maxItemDisplayed: Int  =  3
    @State  var showDropdown: Bool = false
    var placeHolder:String
    @Binding  var selectedOption:ItemPickerModelType?
    var selectedOptionString:String?
    var onTap:(()->Void)
    var onItemSet:((Bool)->Void)


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
                        if !(selectedOption?.name.isEmpty ?? true){
                            Text(placeHolder)
                                .foregroundStyle( Color.colorTextPlaceHolder)
                                .font(.apply(size:12))
                                .offset(y:  -25)
                                .scaleEffect( 0.75, anchor: .leading)


                        }
                        Text(selectedOption?.name ?? placeHolder)
                            .font(.apply(size:17))
                            .foregroundStyle( (selectedOption?.name.isEmpty ?? true) ? Color.colorTextPlaceHolder : Color.colorTextPrimary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
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
            .onChange(of: $selectedOption.wrappedValue?.name ?? "", perform: { value in
                onItemSet(!($selectedOption.wrappedValue?.name ?? "").isEmpty)
        })
    }
}
