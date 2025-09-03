//
//  SelectSharesContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI

struct SelectSharesContentView: View {
    
    var sharesDataTelecom:Binding<[SharesUIModel]?>
    var sharesDataInsurance:Binding<[SharesUIModel]?>
    @State var searchResult:String = ""
    
    var selectedShare:Binding<SharesUIModel?>
    
    var onConfirm:(SharesUIModel?) -> Void
    var onDismiss:() -> Void
    
    var body: some View {
        VStack {
            headerView
            
            searchView
            
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
                
                Text("select_shares".localized)
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
    
    private var searchView: some View {
        HStack {
            Image("ic_search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            TextField("search".localized, text: $searchResult)
                .font(.apply(.regular, size: 14))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1).fill(Color.colorBorder))
        .padding(16)
    }
    
    private var contentView: some View {
        VStack {
//            Text("telecom_sector".localized)
//                .font(.apply(.medium, size: 12))
//                .padding(.horizontal, 15)
//                .padding(.vertical, 8)
//                .frame(maxWidth: .infinity)
//                .background(Color.colorBGSecondary)
            
            ForEach(Array((sharesDataTelecom.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                if searchResult.isEmpty {
                    HStack {
                        Image("\(item.image ?? "")")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 56, height: 27)
                        
                        HStack {
                            Text("\(AppUtility.shared.isRTL ? item.fullNameA ?? "" : item.fullNameE ?? "")")
                                .font(.apply(.semiBold, size: 14))
                            
                            Text(" - ")
                                .font(.apply(.semiBold, size: 14))
                                .padding(.horizontal, 4)

                            Text("\(item.name ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextSecondary)
                        }
                        .padding(.horizontal, 4)


                        
                        Spacer()
                        
                        Image(selectedShare.wrappedValue?.stockId == item.stockId ?? 0 ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedShare.wrappedValue = item
                        }
                    
                    if (index != (sharesDataTelecom.wrappedValue?.count ?? 0) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                } else if !searchResult.isEmpty && (item.name ?? "").lowercased().contains(searchResult.lowercased()) || (AppUtility.shared.isRTL ? (item.fullNameA ?? "").lowercased() : (item.fullNameE ?? "").lowercased()).contains(searchResult.lowercased()) {
                    HStack {
                        Image("\(item.image ?? "")")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 56, height: 27)
                        
                        HStack {
                            Text("\(AppUtility.shared.isRTL ? item.fullNameA ?? "" : item.fullNameE ?? "")")
                                .font(.apply(.semiBold, size: 14))
                            
                            Text(" - ")
                                .font(.apply(.semiBold, size: 14))
                                .padding(.horizontal, 4)

                            Text("\(item.name ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextSecondary)
                        }
                        .padding(.horizontal, 4)


                        
                        Spacer()
                        
                        Image(selectedShare.wrappedValue?.stockId == item.stockId ?? 0 ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedShare.wrappedValue = item
                        }
                    
                    if (index != (sharesDataTelecom.wrappedValue?.count ?? 0) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                }
            }
            
//            Text("insurance_sector".localized)
//                .font(.apply(.medium, size: 12))
//                .padding(.horizontal, 15)
//                .padding(.vertical, 8)
//                .frame(maxWidth: .infinity)
//                .background(Color.colorBGSecondary)
            
            ForEach(Array((sharesDataInsurance.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                if searchResult.isEmpty {
                    HStack {
                        Image("\(item.image ?? "")")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 56, height: 27)
                        
                        HStack {
                            Text("\(AppUtility.shared.isRTL ? item.fullNameA ?? "" : item.fullNameE ?? "")")
                                .font(.apply(.semiBold, size: 14))
                            
                            Text(" - ")
                                .font(.apply(.semiBold, size: 14))
                                .padding(.horizontal, 4)

                            Text("\(item.name ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextSecondary)
                        }
                        .padding(.horizontal, 4)


                        
                        Spacer()
                        
                        Image(selectedShare.wrappedValue?.stockId == item.stockId ?? 0 ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedShare.wrappedValue = item
                        }
                    
                    if (index != (sharesDataInsurance.wrappedValue?.count ?? 0) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
                } else if !searchResult.isEmpty && (item.name ?? "").lowercased().contains(searchResult.lowercased()) || (AppUtility.shared.isRTL ? (item.fullNameA ?? "").lowercased() : (item.fullNameE ?? "").lowercased()).contains(searchResult.lowercased()) {
                    HStack {
                        Image("\(item.image ?? "")")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 56, height: 27)
                        
                        HStack {
                            Text("\(AppUtility.shared.isRTL ? item.fullNameA ?? "" : item.fullNameE ?? "")")
                                .font(.apply(.semiBold, size: 14))
                            
                            Text(" - ")
                                .font(.apply(.semiBold, size: 14))
                                .padding(.horizontal, 4)

                            Text("\(item.name ?? "")")
                                .font(.apply(.semiBold, size: 14))
                                .foregroundStyle(Color.colorTextSecondary)
                        }
                        .padding(.horizontal, 4)


                        
                        Spacer()
                        
                        Image(selectedShare.wrappedValue?.stockId == item.stockId ?? 0 ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            selectedShare.wrappedValue = item
                        }
                    
                    if (index != (sharesDataInsurance.wrappedValue?.count ?? 0) - 1) {
                        Divider()
                            .padding(.horizontal, 20)
                    }
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
                onConfirm(selectedShare.wrappedValue)
            }
    }
}
