//
//  AlertsContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
import SwiftUI

struct AlertsContentView: View {
    
    var alertsData:Binding<[AlertsUIModel]?>
    
    @State var searchResult: String = ""
    
    var onBackTap: () -> Void
    var onAddTap:() -> Void
    
    var body: some View {
        VStack {
            headerView
            
            if alertsData.wrappedValue?.isEmpty == true {
                Spacer()
                contentView
                Spacer()
            } else {
                contentView
                Spacer()
            }
            
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
            
            Text("alerts".localized)
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
        VStack(spacing: 0) {
            if alertsData.wrappedValue?.isEmpty == true {
                VStack(spacing: 0) {
                    Image("ic_noAlerts")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    
                    Text("no_added_alerts".localized)
                        .font(.apply(.medium, size: 16))
                }
            } else {
                VStack(spacing: 0) {
                    searchView
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(Array((alertsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, item in
                            if searchResult.isEmpty {
                                VStack {
                                    HStack {
                                        Image("\(item.image ?? "")")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                        
                                        HStack {
                                            Text("\(AppUtility.shared.isRTL ? item.fullNameAr ?? "" : item.fullNameEn ?? "")")
                                                .font(.apply(.medium, size: 12))

                                            Text(" - ")
                                                .font(.apply(.medium, size: 12))
                                                .padding(.horizontal, 4)

                                            Text("\(item.symbol ?? "")")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)
                                            
                                        }
                                        .padding(.horizontal, 4)
                                                                                
                                        HStack {
                                            Text(item.date ?? "")
                                                .font(.apply(.regular, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)

                                            Image("ic_calendar")
                                                .renderingMode(.template)
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(Color.colorTextPrimary)
                                                .frame(width: 18, height: 18)
                                        }

                                     }
                                        .padding(.top, 4)
                                        .padding(.horizontal, 20)
                                        .frame(maxWidth: .infinity)
                                        .onTapGesture {
                                        }
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        VStack {
                                            Text("value".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.value ?? 0))")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)

                                        VStack {
                                            Text("alert_no".localized)
                                                .font(.apply(.regular, size: 12))
                                             Text("\(AppUtility.shared.formatThousandSeparator(number: item.alertNo ?? 0))")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("price_factor".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.priceFactor ?? "")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("state".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.state ?? "")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorPositiveSecondary)
                                        }
                                        .frame(minWidth: 75.75)

                                    }
                                    .padding(.bottom, 4)
                                }
                                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                                .padding(.horizontal, 20)
                                
                            } else if !searchResult.isEmpty && (item.symbol ?? "").lowercased().contains(searchResult.lowercased()) || (AppUtility.shared.isRTL ? (item.fullNameAr ?? "").lowercased() : (item.fullNameEn ?? "").lowercased()).contains(searchResult.lowercased()) {
                                VStack {
                                    HStack {
                                        Image("\(item.image ?? "")")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                        
                                        HStack {
                                            Text("\(AppUtility.shared.isRTL ? item.fullNameAr ?? "" : item.fullNameEn ?? "")")
                                                .font(.apply(.medium, size: 12))

                                            Text(" - ")
                                                .font(.apply(.medium, size: 12))
                                                .padding(.horizontal, 4)

                                            Text("\(item.symbol ?? "")")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)
                                            
                                        }
                                        .padding(.horizontal, 4)
                                                                                
                                        HStack {
                                            Text(item.date ?? "")
                                                .font(.apply(.regular, size: 12))
                                                .foregroundStyle(Color.colorTextSecondary)

                                            Image("ic_calendar")
                                                .renderingMode(.template)
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundStyle(Color.colorTextPrimary)
                                                .frame(width: 18, height: 18)
                                        }

                                     }
                                        .padding(.top, 4)
                                        .padding(.horizontal, 20)
                                        .frame(maxWidth: .infinity)
                                        .onTapGesture {
                                        }
                                    
                                    Divider()
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        VStack {
                                            Text("value".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.value ?? 0))")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)

                                        VStack {
                                            Text("alert_no".localized)
                                                .font(.apply(.regular, size: 12))
                                             Text("\(AppUtility.shared.formatThousandSeparator(number: item.alertNo ?? 0))")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("price_factor".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.priceFactor ?? "")
                                                .font(.apply(.medium, size: 12))
                                        }
                                        .frame(minWidth: 75.75)
                                        
                                        VStack {
                                            Text("state".localized)
                                                .font(.apply(.regular, size: 12))
                                            Text(item.state ?? "")
                                                .font(.apply(.medium, size: 12))
                                                .foregroundStyle(Color.colorPositiveSecondary)
                                        }
                                        .frame(minWidth: 75.75)

                                    }
                                    .padding(.bottom, 4)
                                }
                                .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
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
