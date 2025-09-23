//
//  TermsAndConditionsContentView.swift
//  mahfazati
//
//  Created by Mohammmed on 09/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import SwiftUI

struct TermsAndConditionsContentView: View {
    
    @State private var isAtBottom = false
    @State private var hasTicked = false
    
    var htmlContent:Binding<String>
    var onContinueTap:(()->Void)
    
    var body: some View {
        
        VStack {
//            AuthHeaderView(type: .back(.pop))
            
            Spacer().frame(height: 40)
            formView
            
            Spacer()
            
            HStack {
                Image(hasTicked == false ?  "ic_checkbox" : "ic_checkboxSelected")
                    .resizable()
                    .frame(width: 20)
                    .frame(height:  20)
                    .onTapGesture {
                        hasTicked.toggle()
                    }
                
                Text("agree_and_sign".localized)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CustomButton(type: .primary, title: "next".localized, onTap: {
                onContinueTap()
            }, enable: $hasTicked)
            
        }
        .padding(.horizontal,16)
        .padding(.vertical,16)
    }
    
    private var formView:some View {
        get{
            let fontName = Font.ThemeFont.bold.cairoFont
            let htmlContent = htmlContent.wrappedValue
            let textColor  = Color.colorTextPrimaryHEX
            let fontSize:CGFloat  = 40

            return   HTMLStringView(htmlContent: htmlContent, font: fontName, fontSize: fontSize, textColor: textColor)

        }
    }

}
