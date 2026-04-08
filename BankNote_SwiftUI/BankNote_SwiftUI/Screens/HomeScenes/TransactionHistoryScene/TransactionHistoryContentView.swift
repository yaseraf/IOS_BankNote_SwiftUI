//
//  TransactionHistoryContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/03/2026.
//

import Foundation
import SwiftUI

struct TransactionHistoryContentView: View {
    
    @Binding var transactionSummaryData: [GetTransactionSummaryUIModel]?
    
    @State private var labelMinWidth: CGFloat = 120
    @State private var labelFontSize: CGFloat = 11
    @State private var valueFontSize: CGFloat = 14
    
    @State private var selectedCardId: String = ""
    
    var onBackTap:()->Void
    
    var body: some View {
        VStack {
            HeaderView()
            
            titleView
            
            contentView
                
            
            Spacer()
        }
    }
    
    private var titleView: some View {
        HStack {
            Button {
                onBackTap()
            } label: {
                Image("ic_backArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
            }
            
            Spacer()
            
            Text("transaction_history".localized)
                .font(.cairoFont(.bold, size: 28))
                .foregroundStyle(.black)

            Spacer()

            Image("ic_backArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                .opacity(0)

        }
        .padding(.horizontal, 18)
    }
    
    private var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(transactionSummaryData ?? [], id: \.id) { item in
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(AppUtility.shared.isRTL ? item.scaLongName ?? "" : item.sceLongName ?? "")")
                        .font(.apply(.semiBold, size: valueFontSize))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    HStack {
                        Text("\(item.tickerID ?? "")")
                            .font(.apply(.semiBold, size: valueFontSize))
                            .frame(minWidth: labelMinWidth, alignment: .leading)

                        Spacer()
                        HStack(spacing: 2) {
                            Text("\(formatDotNetDate(item.trDate ?? "") ?? "")")
                                .font(.apply(.semiBold, size: labelFontSize))
                                .frame(minWidth: labelMinWidth, alignment: .center)
                                .foregroundStyle(.gray)
                            
                            Image("ic_downArrow")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundStyle(Color.colorPrimary)
                                .rotationEffect(.degrees(selectedCardId == item.id ? 180 : 0))
                        }
                    }
                    
                    if selectedCardId == item.id {
                        VStack {
                            Divider()
                                .padding(.horizontal, 12)
                            
                            HStack(alignment: .top) {
                                VStack {
                                    // MARK: -
                                    
                                    // MARK: Type
                                    VStack {
                                        Text("type".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)
                                        
                                        Text("\(item.eDesc ?? "")")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }
                                    
                                    // MARK: Shares Balance
                                    VStack {
                                        Text("share_balance".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)
                                        
                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.bal ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }
                                    
                                    // MARK: Buy Value
                                    VStack {
                                        Text("buy_value".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.bTotal ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }

                                    // MARK: Share Cost
                                    VStack {
                                        Text("share_cost".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.avCost ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }
                                    
                                    // MARK: Profit Loss
                                    VStack {
                                        Text("pnl".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.profit ?? 0))%")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle((item.profit ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)

                                    }
                                }
                                
                                VStack {
                                    // MARK: -

                                    // MARK: Currency
                                    VStack {
                                        Text("currency".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(item.shareCurrency ?? "")")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }
                                    
                                    // MARK: Buy Qty
                                    VStack {
                                        Text("buy_qty".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.bal ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(Color.colorPositive)

                                    }
                                    
                                    // MARK: Sell Value
                                    VStack {
                                        Text("sell_value".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.sTotal ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }

                                    // MARK: Sell Cost
                                    VStack {
                                        Text("sell_cost".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.sellCost ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }
                                }
                                
                                VStack {
                                    // MARK: -

                                    // MARK: Price
                                    VStack {
                                        Text("price".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)
                                        
                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.price ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }
                                    
                                    // MARK: Sell Qty
                                    VStack {
                                        Text("sell_qty".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.bal ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(Color.colorNegative)

                                    }
                                    
                                    // MARK: Total Cost
                                    VStack {
                                        Text("total_cost".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.total ?? 0))")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                    }

                                    // MARK: Delay PnL
                                    VStack {
                                        Text("delay_pnl".localized)
                                            .font(.apply(.regular, size: labelFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle(.gray)

                                        Text("\(AppUtility.shared.formatThousandSeparator(number: item.dResult ?? 0))%")
                                            .font(.apply(.semiBold, size: valueFontSize))
                                            .frame(minWidth: labelMinWidth, alignment: .leading)
                                            .foregroundStyle((item.dResult ?? 0) >= 0 ? Color.colorPositive : Color.colorNegative)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 12)
                .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .padding(.bottom, 4)
                .onTapGesture {
                    withAnimation {
                        if selectedCardId != item.id {
                            selectedCardId = item.id
                        } else {
                            selectedCardId = ""
                        }
                    }
                }

            }
        }
    }
            
    func formatDotNetDate(_ dateString: String) -> String? {
        // Extract milliseconds
        let pattern = #"\/Date\((\d+)"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: dateString, range: NSRange(dateString.startIndex..., in: dateString)),
              let range = Range(match.range(at: 1), in: dateString) else {
            return nil
        }

        let milliseconds = Double(dateString[range]) ?? 0
        let date = Date(timeIntervalSince1970: milliseconds / 1000)

        let formatter = DateFormatter()
        formatter.dateFormat = "M/d/yyyy" // 2/8/2026
        formatter.locale = Locale(identifier: "en_US_POSIX")

        return formatter.string(from: date)
    }


}


#Preview {
    TransactionHistoryContentView(
        transactionSummaryData: .constant([]),
        onBackTap: {
        
        }
    )
}
