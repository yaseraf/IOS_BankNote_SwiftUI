//
//  CreatePinContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/04/2026.
//

import SwiftUI

struct CreatePinContentView: View,BaseContentViewType {

    var onCreatePinTap: ((String) -> Void)

    @State private var enableBtn:Bool = false
    @State var pinInputValue:String = ""
    
    @State var pinLengthLimit = 4
    
    var body: some View {
        VStack(alignment:.center) {

            logoView
            
            Spacer().frame(height: 20)

            titleView

            formView

            Spacer()

            bottomsView
        }
    }

    private var logoView: some View {
        VStack(spacing: 0) {
            Image(AppUtility.shared.APP_LOGO)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150, maxHeight: 150)
                .padding(.top, 90)

            Text(AppUtility.shared.APP_NAME)
                .foregroundStyle(Color(hex: AppUtility.shared.APP_MAIN_COLOR))
                .font(.cairoFont(.extraBold, size: 40))
                .padding(.bottom, 60)
        }
    }


    private var titleView:some View {
        get{
            Text("create_your_pin".localized)
                .font(Font.apply(.bold,size: 28))
                .foregroundColor(.colorTextPrimary)
        }
    }

    private var formView:some View {
        get{
            VStack(alignment: .leading) {
                TextField("pin".localized, text: $pinInputValue)
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                    .padding(.bottom, 8)
                    .onChange(of: pinInputValue) { newValue in
                        if newValue.count > pinLengthLimit {
                            pinInputValue = String(newValue.prefix(pinLengthLimit))
                        }
                    }

            }
        }
    }

    private func checkNextBtn() {
        enableBtn = pinInputValue.count == pinLengthLimit
    }



    private var bottomsView:some View {
        Button {
            onCreatePinTap(pinInputValue)
        } label: {
            Text("continue".localized)
                .font(.cairoFont(.semiBold, size: 14))
                .foregroundStyle(.white)
                .frame(minWidth: 169, minHeight: 51)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
        }
    }


}
