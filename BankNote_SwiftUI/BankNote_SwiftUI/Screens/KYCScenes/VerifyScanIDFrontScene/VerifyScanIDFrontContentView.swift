//
//  VerifyScanIDFrontContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct VerifyScanIDFrontContentView: View {
    
    var address:Binding<String>
    var name:Binding<String>
    var dateOfBirth:Binding<String>
    var idNumber:Binding<String>
    var idKey:Binding<String>
        
    @State var stepNumber:Int = 3
    
    var onNextTap:()->Void
    var onRetakeTap:()->Void
    
    var body: some View {
        VStack {
            logoView
            
            segmentsView
            
            contentView
                        
            Spacer()
            
            bottomView
                        
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
    
    private var contentView: some View {
        VStack(spacing: 0) {
            Text("confirm_data".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
            fieldsView
                .padding(.vertical, 7)
            
        }
    }
    
    private var fieldsView: some View {
        VStack(spacing: 8) {
            
            // Full Name
            VStack(alignment: .leading, spacing: 0) {
                Text("full_name".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(name.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)
            
            // Address
            VStack(alignment: .leading, spacing: 0) {
                Text("address".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(address.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)

            
            // Date of birth
            VStack(alignment: .leading, spacing: 0) {
                Text("date_of_birth".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(dateOfBirth.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)

            // ID Number
            VStack(alignment: .leading, spacing: 0) {
                Text("id_number".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(idNumber.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)
           
            // ID Key
            VStack(alignment: .leading, spacing: 0) {
                Text("id_key".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(idKey.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)
        }
        .disabled(true)
    }

    private var bottomView: some View {
        HStack {
            Button {
                onRetakeTap()
            } label: {
                Text("retake".localized)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#828282")))
            }
            
            Button {
                onNextTap()
            } label: {
                Text("next".localized)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
    }

}

#Preview {
    VerifyScanIDFrontContentView(address: .constant(""), name: .constant(""), dateOfBirth: .constant(""), idNumber: .constant(""), idKey: .constant(""), stepNumber: 0, onNextTap: {
        
    }, onRetakeTap: {
        
    })
}
