//
//  VerifyIDConfirmationContentView.swift
//  mahfazati
//
//  Created by FIT on 06/04/2025.
//  Copyright © 2025 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI

struct VerifyIDConfirmationContentView: View {
    
    var isFrontID:Binding<Bool>
    var address:Binding<String>
    var name:Binding<String>
    var dateOfBirth:Binding<String>
    var idNumber:Binding<String>
    var idKey:Binding<String>
    var gender:Binding<String>
    var jobTitle:Binding<String>
    var religion:Binding<String>
    var maritalStatus:Binding<String>
    
    var onRetakeTap:(()->Void)
    var onNextTap:(()->Void)
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    
                    Spacer()
                    
                    fieldsView
                        .padding()
                    bottomButtonView(geometry: geometry)
                        .padding()

                    Spacer()
                }
            }
        }
    }
    
    private func bottomButtonView(geometry: GeometryProxy) -> some View {
        HStack(){
            CustomButton(type: .darkGrey, title: "retake".localized) {
                // pop to previous scene
                onRetakeTap()
            }

            Spacer().frame(width: 8)

            CustomButton(type: .primary, title: "next".localized,iconImageName: "ic_rightArrow",onTap:  {
                
                // Push the camera scene with the new step index
                onNextTap()
                }
            )
        }
        .frame(maxWidth: .infinity)

    }
    
    
    
    private var fieldsView: some View {
        return VStack {
            if isFrontID.wrappedValue {
                ZStack(alignment: .leading) {
                    Text("address".localized)
                        .foregroundStyle( Color.colorTextPlaceHolder)
                        .font(.system(size: 8))
                        .offset(y:  -15)
                        .frame(maxWidth: .infinity, alignment: AppUtility.shared.isRTL ? .trailing : .leading)

                    HStack(alignment:.center){
                        Text(address.wrappedValue)
                    }


                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.colorBorderPrimary, lineWidth: 1)
                )
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.colorBGTertiary)
                )
                
                CustomTextField(type: .name, title: "name".localized, value: name, countryCodeUIModel: .constant(nil)).disabled(true)
                
                CustomTextField(type: .name, title: "dateOfBirth".localized, value: dateOfBirth, countryCodeUIModel: .constant(nil)).disabled(true)
                
                CustomTextField(type: .name, title: "idNumber".localized, value: idNumber, countryCodeUIModel: .constant(nil)).disabled(true)
                
                CustomTextField(type: .name, title: "idKey".localized, value: idKey, countryCodeUIModel: .constant(nil)).disabled(true)
            } else {
                CustomTextField(type: .name, title: "gender".localized, value: gender, countryCodeUIModel: .constant(nil)).disabled(true)
                
                CustomTextField(type: .name, title: "jobTitle".localized, value: jobTitle, countryCodeUIModel: .constant(nil)).disabled(true)
                
                CustomTextField(type: .name, title: "religion".localized, value: religion, countryCodeUIModel: .constant(nil)).disabled(true)
                
                CustomTextField(type: .name, title: "maritalStatus".localized, value: maritalStatus, countryCodeUIModel: .constant(nil)).disabled(true)
            }
        }
    }

}
