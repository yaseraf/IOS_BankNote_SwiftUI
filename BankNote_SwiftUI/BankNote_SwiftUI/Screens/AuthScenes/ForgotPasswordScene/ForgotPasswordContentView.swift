//
//  ForgotPasswordContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import SwiftUI

struct ForgotPasswordContentView: View {
    
    var forgotType:Binding<ForgotDataEnum>
    @State var nin:String = ""
    @State var qid:String = ""
    @State var username: String = ""
    var onBack:()->Void
    var onSubmit:()->Void
    var onLoginTap:()->Void
    var onCountryPickerTap:()->Void
    var onResendLinkTap:()->Void
    
    
    var body: some View {
        ZStack {
            VStack {
                            
                headerView
                
                logoView
                
                titleView
                
                fieldView
                
                bottomView
                
                Spacer()
            }
        }
    }
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 225, maxHeight: 225)
            
            Text("XNTRQ".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 40))
        }
    }
    
    private var headerView: some View {
        HStack {
            Image("ic_close")
                .resizable()
                .scaledToFit()
                .frame(width: 38, height: 38)
                .onTapGesture {
                    onBack()
                }
            Spacer()
        }
        .padding(.horizontal, 18)
    }
    
    private var titleView: some View {
        VStack {
            Text("\("forgot_password".localized)?")
                .font(.cairoFont(.semiBold, size: 18))
            Text("please_enter_your_phone_number_and_well_send_you_a_link_to_change_password")
                .font(.cairoFont(.light, size: 12))
                .padding(.horizontal, 77)
                .multilineTextAlignment(.center)
            
        }
    }
    
    private var fieldView: some View {
        HStack(spacing: 8) {
            Button(action: {
                onCountryPickerTap()
            }, label: {
                HStack {
                    Text("🇪🇬 +20")
                        .font(.cairoFont(.semiBold, size: 12))
                    Image("ic_downArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 6)
                }
                .foregroundStyle(Color(hex: "#1C1C1C"))
                .padding(.horizontal, 16)
                .frame(height: 56)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                .padding(.bottom, 24)
            })
            
            TextField("enter_your_user_name".localized, text: $username)
                .font(.cairoFont(.semiBold, size: 12))
                .foregroundStyle(Color(hex: "#1C1C1C"))
                .padding(.horizontal, 16)
                .frame(height: 56)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                .padding(.bottom, 24)

            

        }
        .padding(.horizontal, 18)

    }
    
    private var bottomView: some View {
        var resentAttribute: AttributedString {
            var str = AttributedString("\("resend_link".localized) in 02:41")
            str.underlineStyle = .single
            return str
        }
        
        var continueWithPhoneNumberAttribute: AttributedString {
            var str = AttributedString("continue_with_phone_number".localized)
            str.underlineStyle = .single
            return str
        }
        
        return VStack {
            Button {
                onLoginTap()
            } label: {
                Text("continue".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
            
            Spacer().frame(height: 24)
            
            Button {
                onLoginTap()
            } label: {
                Text(resentAttribute)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(Color(hex: "#828282"))
            }
            
            Spacer().frame(height: 34)
            
            Button {
                onLoginTap()
            } label: {
                Text(continueWithPhoneNumberAttribute)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(Color(hex: "#629AF9"))
            }

        }
    }
}

#Preview {
    ForgotPasswordContentView(forgotType: .constant(.forgotPassword), nin: "", qid: "", username: "", onBack: {
        
    }, onSubmit: {
        
    }, onLoginTap: {
        
    }, onCountryPickerTap: {
        
    }, onResendLinkTap: {
        
    })
}
