//
//  CustomButton.swift
//  QSC
//
//  Created by FIT on 23/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct CustomButton: View {
    enum ButtonType{
        case custom(Color)
        case primary
        case grey
        case darkGrey

    }
    
    private  var type:ButtonType
    private var enable:Binding<Bool>

    
    private var title:String
    private var fontTitle:Font
    private var paddingTitle:CGFloat
    private var height:CGFloat
    private var iconImageName:String
    private var isLoading:Binding<Bool>
    private var disabledButton:Bool

    private var onTap:(()->Void)?
    init(type: ButtonType, title: String,fontTitle:Font = Font.apply(.bold,size: 17),paddingTitle:CGFloat = 16,height:CGFloat = 50,iconImageName:String = "",isLoading:Binding<Bool> = .constant(false), disabledButton:Bool = false, onTap: ( () -> Void)? = nil,enable:Binding<Bool> = .constant(true) ) {
        self.type = type
        self.title = title
        self.fontTitle = fontTitle
        self.paddingTitle = paddingTitle
        self.height = height
        self.iconImageName = iconImageName
        self.onTap = onTap
        self.enable = enable
        self.isLoading = isLoading
        self.disabledButton = disabledButton
    }
    var body: some View {
        
        Button {
            if enable.wrappedValue{
                onTap?()
            }
        } label: {
            HStack(alignment:.center){
                if isLoading.wrappedValue{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .colorWhite))
                }else{
                    Text(title)
                        .foregroundColor(disabledButton ? Color.init(hex: "#667585") : foregroundColor)
                        .font(fontTitle)
                        .padding(.vertical,paddingTitle)

                    if !iconImageName.isEmpty{

                        Spacer().frame(width: 13)

                        Image(iconImageName)
                            .resizable()
                            .renderingMode(.template)
                            .scaleEffect(x: AppUtility().isRTL ?  -1 : 1 , y: 1)
                            .frame(width: 14)
                            .frame(height:14)
                            .foregroundStyle(foregroundColor)

                    }
                }

            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: height)
            .background( backgroundColor)
            .cornerRadius(14)
            


        }
    }
    
    private var backgroundColor:Color {
        get{
          var color  =   switch type {
            case .primary:
                 Color.colorPrimary
            case .grey:
                  Color.colorBGButtonSecondary
 
          case .darkGrey:
              Color.colorDarkGrayButton

          case .custom(let color):
              color
          }

            if !enable.wrappedValue{
                color  = Color.colorBGDisable
            }
            return color
        }
    }
    
    private var foregroundColor:Color {
        get{
            var color  =   switch type {
            case .primary,.darkGrey,.custom:
                 Color.colorWhite
            case .grey:
                  Color.colorTextPrimary
            }

            if !enable.wrappedValue{
                color  = Color.colorTextDisable
            }
            return color

        }
    }
    
}



#Preview {
    Group {
        
        CustomButton(type: .primary, title: "create_an_account".localized, onTap: {
        })
        CustomButton(type: .grey, title: "log_in".localized, onTap: {
        })
    }
    
}
