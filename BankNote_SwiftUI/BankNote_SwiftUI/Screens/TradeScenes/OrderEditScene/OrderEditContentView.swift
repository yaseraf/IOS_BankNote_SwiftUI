//
//  OrderEditContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/10/2025.
//

import Foundation
import SwiftUI

struct OrderEditContentView: View {
    
    var orderDetails:Binding<OrderListUIModel?>
    
    var onEditTap:() -> Void
    var onCancelTap:() -> Void
    var onDismiss:() -> Void
    
    var body: some View {
        VStack {
            headerView
                        
            contentView
            
            Spacer()
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
                
                Text("order_details".localized)
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
        .padding(.top, 16)
    }
    
    
    private var contentView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 8) {
                OrderDetailsInfoCard(title: "order_no".localized, value: orderDetails.wrappedValue?.OrderID ?? "")
                OrderDetailsInfoCard(title: "order_value".localized, value: orderDetails.wrappedValue?.OrderTypeCode == "1" ? "mkt".localized : orderDetails.wrappedValue?.LocalValue ?? "")
            }

            HStack(spacing: 8) {
                OrderDetailsInfoCard(title: "order_type".localized, value: orderDetails.wrappedValue?.OrderTypeCode ?? "" == "1" ? "market_order".localized : "limit_order".localized)
                OrderDetailsInfoCard(title: "good_till".localized, value: AppUtility.shared.isRTL ? UserDefaultController().tifList?.filter({$0.id == "000\(orderDetails.wrappedValue?.ValidityCode ?? "")"}).first?.descA ?? "" :
                    UserDefaultController().tifList?.filter({$0.id == "000\(orderDetails.wrappedValue?.ValidityCode ?? "")"}).first?.descE ?? "" )
            }
            
            VStack(spacing: 0) {
                Text("rejection_reason".localized)
                    .font(.apply(.regular, size: 14))
                Text(orderDetails.wrappedValue?.RejectReason ?? "")
                    .font(.apply(.semiBold, size: 16))
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }
            .frame(maxHeight: 68)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12).fill(AppUtility.shared.isDarkTheme ? Color(hex: "#1F1F1F") : Color(hex: "#F6F7FB"))
                    RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
                }
            )

            

            if orderDetails.wrappedValue?.StatusCode?.lowercased() != "r" && orderDetails.wrappedValue?.StatusCode?.lowercased() != "c" && orderDetails.wrappedValue?.StatusCode?.lowercased() != "e" && orderDetails.wrappedValue?.StatusCode?.lowercased() != "s" {
                Divider()
                HStack(spacing: 8) {
                    
                    Button {
                        onCancelTap()
                    } label: {
                        Text("cancel".localized)
                            .font(.apply(.medium, size: 16))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.colorNegativeSecondary))
                    }
                    
                    Button {
                        onEditTap()
                    } label: {
                        Text("edit".localized)
                            .font(.apply(.medium, size: 16))
                            .foregroundStyle(Color.colorPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorPrimary))
                    }

                }
                .padding(.bottom, 8)

            }
        }
            .padding(.horizontal, 24)
    }
}

struct OrderDetailsInfoCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.apply(.regular, size: 14))
            Text(value)
                .font(.apply(.semiBold, size: 16))
        }
        .frame(maxHeight: 68)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(AppUtility.shared.isDarkTheme ? Color(hex: "#1F1F1F") : Color(hex: "#F6F7FB"))
                RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder)
            }
        )
    }
}


#Preview {
    OrderEditContentView(orderDetails: .constant(.initializer()), onEditTap: {
        
    }, onCancelTap: {
        
    }, onDismiss: {
        
    })
}
