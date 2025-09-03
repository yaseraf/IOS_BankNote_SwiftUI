//
//  AddAlertContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
import SwiftUI

struct AddAlertContentView: View {
    
    var selectedShare:Binding<SharesUIModel?>
    var selectedPriceFactor:Binding<PriceFactorUIModel?>
    var shareValue:Binding<String>
    var selectedExpiryTime:Binding<String?>

    
    enum Field {
        case shareValue
    }
    
    @FocusState private var focusedField: Field?


    var onBackTap:() -> Void
    var onAddTap:() -> Void
    var onSelectSharesTap: () -> Void
    var onSelectPriceFactorTap: () -> Void
    var onSelectExpiryTimeTap: () -> Void

    var body: some View {
        VStack {
            headerView
            
            contentView
            
            Spacer()
            
            Divider().padding(.vertical, 4)
            bottomButtonView
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .overlay {
                    Image(AppUtility.shared.isRTL ? "ic_rightArrow" : "ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    onBackTap()
                }
            
            Spacer()
            
            Text("add_alert".localized)
                .font(.apply(.medium, size: 16))

            Spacer()
            
            Circle()
                .fill(Color.colorBGSecondary)
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(20)
    }
    
    private var contentView: some View {
        VStack(spacing: 16) {
            
            // Select Share
            VStack(alignment: .leading, spacing: 4) {
                Text("select_the_share".localized)
                    .font(.apply(.semiBold, size: 14))
                
                HStack {
                    
                    Text(((selectedShare.wrappedValue?.name != "") ? "\((AppUtility.shared.isRTL ? selectedShare.wrappedValue?.fullNameA : selectedShare.wrappedValue?.fullNameE) ?? "") - \(selectedShare.wrappedValue?.name ?? "")" : "please_select_the_share".localized))
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onSelectSharesTap()
                }
            }
            .padding(.horizontal, 16)
            
            // Select Price Factor
            VStack(alignment: .leading, spacing: 4) {
                Text("price_factor".localized)
                    .font(.apply(.semiBold, size: 14))
                
                HStack {
                    
                    Text(((selectedPriceFactor.wrappedValue?.factorName != nil) ? "\(selectedPriceFactor.wrappedValue?.factorName ?? "")".localized : "please_select_a_price_factor".localized))
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onSelectPriceFactorTap()
                }
            }
            .padding(.horizontal, 16)

            // Share Value
            VStack(alignment: .leading, spacing: 4) {
                Text("share_value".localized)
                    .font(.apply(.semiBold, size: 14))
                
                TextField("please_enter_total_amount".localized, text: shareValue)
                    .font(.apply(.regular, size: 14))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .shareValue)
                    .toolbar {
                           ToolbarItemGroup(placement: .keyboard) {
                               Spacer()
                               Button("Done") {
                                   focusedField = nil
                               }
                           }
                       }
                    
            }
            .padding(.horizontal, 16)

            
            // Select Expiry time
            VStack(alignment: .leading, spacing: 4) {
                Text("expiry_time".localized)
                    .font(.apply(.semiBold, size: 14))
                
                HStack {
                    
                    Text(((selectedExpiryTime.wrappedValue != "") ? "\(selectedExpiryTime.wrappedValue ?? "")" : "please_select_specific_date".localized))
                        .font(.apply(.regular, size: 14))
                        .foregroundStyle(Color.colorTextSecondary)
                    
                    Spacer()
                    
                    Circle()
                        .fill(Color.colorBGSecondary)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Image("ic_downArrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                        }
                }
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .onTapGesture {
                    onSelectExpiryTimeTap()
                }
            }
            .padding(.horizontal, 16)

        }
    }
    
    private var bottomButtonView: some View {
        Text("add_alert".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onAddTap()
            }
    }


}
