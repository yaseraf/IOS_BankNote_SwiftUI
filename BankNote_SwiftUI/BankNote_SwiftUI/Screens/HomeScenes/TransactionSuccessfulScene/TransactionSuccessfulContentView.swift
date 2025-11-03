//
//  TransactionSuccessfulContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct TransactionSuccessfulContentView: View {
    
    var onBackToHomeTap:()->Void
    
    var body: some View {
        VStack(spacing: 20) {
            
            headerView
            
            summaryView
            
            backToHomeButton
            
            Spacer()
            
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack(spacing: 0) {
                HStack(spacing: 16) {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 45, height: 45)
                        .foregroundStyle(Color(hex: "#DDDDDD"))
                        .overlay {
                            Image("ic_topUp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                    
                    Text("top_up".localized)
                        .font(.cairoFont(.semiBold, size: 18))
                }
                
                Spacer()

                Text("\("egp".localized)0.00")
                    .font(.cairoFont(.semiBold, size: 18))
            }
            .padding(.horizontal, 18)
            
            VStack(spacing: 0) {
                Image("ic_success")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 169, height: 169)
                
                Text("successful".localized)
                    .font(.cairoFont(.bold, size: 32))
                    .foregroundStyle(Color(hex: "#629AF9"))
            }
        }
        .padding(.top, 75)
    }
    
    private var summaryView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("summary".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
            HStack(spacing: 0) {
                Text("top_up".localized)
                    .font(.cairoFont(.semiBold, size: 12))
                
                Spacer()
                
                Text("0.00 \("egp".localized)")
                    .font(.cairoFont(.semiBold, size: 12))
            }
            
            HStack(spacing: 0) {
                Text("paid_with".localized)
                    .font(.cairoFont(.semiBold, size: 12))
                
                Spacer()
                
                Text("****-****-****-1234")
                    .font(.cairoFont(.semiBold, size: 12))
            }

        }
        .padding(.horizontal, 18)

    }
    
    private var backToHomeButton: some View {
        Button {
            onBackToHomeTap()
        } label: {
            Text("back_to_home".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
        .padding(.horizontal, 18)

    }
}

#Preview {
    TransactionSuccessfulContentView(onBackToHomeTap: {
        
    })
}
