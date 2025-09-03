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
    var onBack:()->Void
    var onSubmit:()->Void
    
    var body: some View {
        VStack {
                        
            headerView
            
            Spacer().frame(height: 20)
            
            inputFieldsView
            
            Spacer().frame(height: 20)
            
            contactInformationView
            
            Spacer()
            
            submitView
            
            Spacer().frame(height: 20)
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(hex: "#EDEEF6"))
                .overlay {
                    Image("ic_back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .scaleEffect(AppUtility.shared.isRTL ? -1 : 1)
                }
                .onTapGesture {
                    onBack()
                }
            
            Spacer()
            
            Text(forgotType.wrappedValue == .forgotPassword ? "forgot_password".localized : forgotType.wrappedValue == .forgotName ? "forgot_name".localized : forgotType.wrappedValue == .forgotPin ? "forgot_pin".localized : "")
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
            
            Circle()
                .frame(width: 40, height: 40)
                .opacity(0)
            
        }
    }
    
    private var inputFieldsView: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("nin".localized)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
                
                TextField("type_nin".localized, text: $nin)
                    .font(.apply(size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
            }
            
            VStack(alignment: .leading) {
                Text("qid".localized)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)
                
                TextField("type_your_national_identity_number".localized, text: $qid)
                    .font(.apply(size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)
            }

        }
    }
    
    private var contactInformationView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("contact_us_for_further_assistance".localized)
                .foregroundStyle(Color.colorTextPrimary)
                .font(.apply(.medium, size: 14))

            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Image("ic_phone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("(+974)44255273")
                    .foregroundStyle(Color.colorTextPrimary)
                    .font(.apply(size: 14))

            }
            
            HStack {
                Image("ic_mail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(verbatim: "info@qsc.qa")
                    .font(.apply(size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 134)
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
    }
    
    private var submitView: some View {
        Text("submit".localized)
            .font(.apply(.medium, size: 18))
            .foregroundStyle(.white)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary).opacity(nin.isEmpty == false && qid.isEmpty == false ? 1 : 0.5))
            .padding(.horizontal, 20)
            .onTapGesture {
                onSubmit()
            }
    }
}
