//
//  VerifyIDConfirmationContentView.swift
//  mahfazati
//
//  Created by FIT on 06/04/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct VerifyIDConfirmationContentView: View {
    
    var stepNumber = 4
    
    var fullName:Binding<String>
    var address:Binding<String>
    var dateOfBirth:Binding<String>
    var idNumber:Binding<String>
    var idKey:Binding<String>
    
    var onRetakeTap:(()->Void)
    var onNextTap:(()->Void)
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                
                headerView
                
                logoView
                
                segmentsView
                
                fieldsView
                    .padding()
                
                Spacer()

                bottomButtonView()
                    .padding()

            }
        }
    }
    
    private var headerView: some View {
        HStack {
            Button {
                onRetakeTap()
            } label: {
                Image("ic_leftArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 45, maxHeight: 45)
            }
            
            Spacer()
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
    
    private var segmentsView: some View {
        HStack(spacing: 4) {
            ForEach(0...5, id: \.self) { index in
                if stepNumber > index {
                    LinearGradient( gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]), startPoint: .leading, endPoint: .trailing)
                    
                        .cornerRadius(12)
                } else {
                    RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#DDDDDD"))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 6)
        .padding(.horizontal, 18)
    }
    
    private var fieldsView: some View {
        return VStack(spacing: 12) {
            
            Text("confirm_data".localized)
                .font(.cairoFont(.medium, size: 18))

            InputField(
                title: "full_name",
                text: fullName,
                isValid: true,
                onTextAction: { text in
                    
                }
            )
            .disabled(true)

            InputField(
                title: "address",
                text: address,
                isValid: true,
                onTextAction: { text in
                    
                }
            )
            .disabled(true)
            
            InputField(
                title: "date_of_birth",
                text: dateOfBirth,
                isValid: true,
                onTextAction: { text in
                    
                }
            )
            .disabled(true)
            
            InputField(
                title: "id_number",
                text: idNumber,
                isValid: true,
                onTextAction: { text in
                    
                }
            )
            .disabled(true)
            
            InputField(
                title: "id_key",
                text: idKey,
                isValid: true,
                onTextAction: { text in
                    
                }
            )
            .disabled(true)
        }
    }

    
    private func bottomButtonView() -> some View {
        HStack(){
            CustomButton(type: .custom(Color(hex: "#828282")), title: "retake".localized) {
                // pop to previous scene
                onRetakeTap()
            }
            .cornerRadius(32)

            Spacer().frame(width: 8)

            CustomButton(type: .primary, title: "next".localized,onTap:  {
                
                // Push the camera scene with the new step index
                onNextTap()
                }
            )
            .cornerRadius(32)

        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VerifyIDConfirmationContentView(
        fullName: .constant("ahmad"),
        address: .constant(""),
        dateOfBirth: .constant(""),
        idNumber: .constant(""),
        idKey: .constant(""),
        onRetakeTap: {
        
        },
        onNextTap: {
        
        }
    )
}
