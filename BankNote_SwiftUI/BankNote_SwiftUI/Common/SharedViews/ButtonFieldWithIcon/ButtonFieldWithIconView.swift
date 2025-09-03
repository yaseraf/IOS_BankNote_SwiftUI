//
//  ButtonFieldWithIconView.swift
//  QSC
//
//  Created by FIT on 22/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct ButtonFieldWithIconView: View {
    var title:String
    var font:Font
    var value:Binding<String>
    var iconName:String
    var onTap:(()->Void)
    init(title: String, font: Font = Font.apply(size:17), value: Binding<String>, iconName: String, onTap: @escaping () -> Void) {
        self.title = title
        self.font = font
        self.value = value
        self.iconName = iconName
        self.onTap = onTap
    }

    var body: some View {
        Button(action: {
            onTap()
        }, label: {
            HStack(spacing: nil) {
                ZStack(alignment: .leading){
                    if !(value.wrappedValue.isEmpty){
                        Text(title)
                            .foregroundStyle( Color.colorTextPlaceHolder)
                            .font(.apply(size:12))
                            .offset(y:  -25)
                            .scaleEffect( 0.75, anchor: .leading)


                    }
                    Text(value.wrappedValue.isEmpty ? title : value.wrappedValue )
                        .font(.apply(size:17))
                        .foregroundStyle( value.wrappedValue.isEmpty ? Color.colorTextPlaceHolder : Color.colorTextPrimary)
                }
                Spacer()
                Image( iconName)
                    .tint(Color.colorTextPlaceHolder)
            }
        })
        .padding(.horizontal, 20)
        .frame(maxWidth:.infinity)
        .frame(height:50)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.colorBorderPrimary, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.colorBGTertiary)
        )
    }
}

#Preview {
    ButtonFieldWithIconView(title: "Date", value: .constant(""), iconName: "ic_calendar", onTap: {})
}
