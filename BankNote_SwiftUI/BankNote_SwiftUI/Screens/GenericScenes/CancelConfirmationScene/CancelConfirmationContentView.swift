//
//  SelectSharesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI

struct CancelConfirmationContentView: View {
        
    @Binding var transactionTypes:TransactionTypes?
    var onConfirm:() -> Void
    var onDismiss:() -> Void
    
    var body: some View {
        VStack {
            headerView
                        
            contentView
            
            Spacer()
            
            bottomButtonView
        }
    }
    
    private var headerView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.colorBorder)
                .frame(maxWidth: 46, maxHeight: 4)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("confirmation".localized)
                    .font(.apply(.medium, size: 16))
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .background(Circle().stroke(lineWidth: 1).fill(Color.colorBorder))
                    .onTapGesture {
                        onDismiss()
                    }
            }
            .padding(.horizontal, 24)
        }
    }
    
    
    private var contentView: some View {
        VStack(alignment: .center) {
            Image("ic_info")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text(transactionTypes == .cashIn ? "are_you_sure_you_want_to_delete_your_cash_in_request".localized : transactionTypes == .cashOut ? "are_you_sure_you_want_to_delete_your_cash_out_request".localized : transactionTypes == .shareTransfer ? "are_you_sure_you_want_to_delete_your_share_transfer_request".localized : "")
                .font(.apply(.regular, size: 16))
                .foregroundStyle(Color.colorTextSecondary)
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var bottomButtonView: some View {
        Text("confirm_cancellation_request".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onConfirm()
            }
    }
}
