//
//  VerifyScanIDFrontContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct VerifyScanIDBackContentView: View {
    
    
    var gender:Binding<String>
    var jobTitle:Binding<String>
    var religion:Binding<String>
    var maritalStatus:Binding<String>
                                
    @State var stepNumber:Int = 4
    
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
            
            // Gender
            VStack(alignment: .leading, spacing: 0) {
                Text("gender".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(gender.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)

            // Job Title
            VStack(alignment: .leading, spacing: 0) {
                Text("job_title".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(jobTitle.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)

            // Religion
            VStack(alignment: .leading, spacing: 0) {
                Text("religion".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(religion.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
            .padding(.horizontal, 18)


            // Marital Status
            VStack(alignment: .leading, spacing: 0) {
                Text("marital_status".localized)
                    .font(.cairoFont(.light, size: 12))
                Text(maritalStatus.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 12))
            }
            .padding(.vertical, 5.5)
            .padding(.horizontal, 12)
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
    VerifyScanIDFrontContentView(address: .constant(""), name: .constant(""), dateOfBirth: .constant(""), idNumber: .constant(""), idKey: .constant(""), onNextTap: {
        
    }, onRetakeTap: {
        
    })
}
