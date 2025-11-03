//
//  SelectSharesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI

struct SelectPortfolioContentView: View {
    
    var usersData:Binding<[UserUIModel]?>
    var selectedUser:Binding<UserUIModel?>
    
    var onConfirm:(UserUIModel?) -> Void
    var onDismiss:() -> Void
    
    var body: some View {
        VStack {
            headerView
                        
            ScrollView(.vertical, showsIndicators: false) {
                contentView
            }
            
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
                
                Text("select_portfolio".localized)
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
        VStack {
            ForEach(Array((usersData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                HStack {
                    Text("\(AppUtility.shared.isRTL ? item.nameAr ?? "" : item.nameEn ?? "")")
                        .font(.apply(.semiBold, size: 14))
                    
                    Spacer()
                    
                    Image(selectedUser.wrappedValue?.userID == item.userID ?? "" ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        selectedUser.wrappedValue = item
                    }
                
                if (index != (usersData.wrappedValue?.count ?? 0) - 1) {
                    Divider()
                        .padding(.horizontal, 20)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var bottomButtonView: some View {
        Text("confirm".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onConfirm(selectedUser.wrappedValue)
            }
    }
}
