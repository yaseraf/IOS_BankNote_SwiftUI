//
//  SignUpContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import FlagAndCountryCode

enum VerificationType {
    case phone
    case email
}

struct SignUpContentView: View {
        
    var verifyWithEmail: Bool
    @Binding var countryCodeUIModel: CountryFlagInfo?
    var locationPermission:Binding<Bool>
    @State private var viewType:AuthenticationViewType = .phoneNumber
    @State var verificationType: VerificationType = .phone
    var phone: Binding<String>
    var email: Binding<String>
    @State var passwordInputValue:String = ""
    var onBack:()->Void
    var onContinueTap:((_ otpUIModel:VerifyOTPUIModel, _ verifyWithEmail:Bool, _ phoneNumber: String, _ email: String, _ password: String) -> Void)?
    var onCountryPickerTap:((CountryFlagInfo?) -> Void)
    var onLocationAlertTap:()->Void

    
    var body: some View {
        ZStack {
            VStack {
                                            
                logoView
                
                titleView
                
                fieldView
                
                bottomView
                
                Spacer()
            }
            
            // Location Alert
            if locationPermission.wrappedValue == true {
                VStack {
                    Text("please_enable_location_from_settings".localized)
                        .padding(.vertical, 8)
                    
                    Button(action: {
                        onLocationAlertTap()
                    }, label: {
                        Text("ok".localized)
                            .padding(.bottom, 8)
                            .padding(.horizontal, 12)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.colorPrimary,lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.colorPrimary))
                                        .padding(.bottom, 8)
                            )
                    })
                }
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.colorPrimary,lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.colorBGPrimary))

                )
            }
        }
    }
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 225, maxHeight: 225)
            
            Text("bank_note".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 40))
        }
    }
        
    private var titleView: some View {
        VStack {
            Text(verificationType == .phone ? "continue_with_phone".localized : "continue_with_email".localized)
                .font(.cairoFont(.semiBold, size: 18))
            Text(verificationType == .phone ? "well_send_a_6_digit_verification_code_to_this_number_to_verify_it".localized : "well_send_a_6_digit_verification_code_to_this_email_to_verify_it".localized)
                .font(.cairoFont(.light, size: 12))
                .padding(.horizontal, 77)
                .multilineTextAlignment(.center)
            
        }
    }
    
    private var fieldView: some View {
        HStack(spacing: 8) {
            if verificationType == .phone {
                Button(action: {
                    onCountryPickerTap(countryCodeUIModel)
                }, label: {
                    HStack {
                        countryCodeUIModel?.getCountryImage(with: FlagType(rawValue: 0) ?? .roundedRect)
                            .frame(width: 30)
                        
                        Text("\(countryCodeUIModel?.dialCode ?? "")")
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(.black)

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
            }
            
            TextField(verificationType == .phone ? "phone_number".localized : "example@gmail.com".localized, text: verificationType == .phone ? phone : email)
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
    
        let value = viewType == .phoneNumber ? phone.wrappedValue : email.wrappedValue
        let uiModel = VerifyOTPUIModel(viewType: viewType, value: value)

        return VStack {
            Button {
                onContinueTap?(uiModel, verifyWithEmail, "\(countryCodeUIModel?.dialCode ?? "")\(phone.wrappedValue)", email.wrappedValue, passwordInputValue)
            } label: {
                Text("continue".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
            
            Spacer().frame(height: 24)
        }
    }
}


#Preview {
    SignUpContentView(verifyWithEmail: false, countryCodeUIModel: .constant(.none), locationPermission: .constant(false), verificationType: .email, phone: .constant(""), email: .constant(""), onBack: {
        
    }, onContinueTap: {otpUIModel,verifyWithEmail,phoneNumber,email,password in 
        
    }, onCountryPickerTap: {_ in 
        
    }, onLocationAlertTap: {
        
    })
}
