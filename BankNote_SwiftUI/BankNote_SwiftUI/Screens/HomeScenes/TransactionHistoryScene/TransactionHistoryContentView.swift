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
    
    var onBackTap:()->Void
    
    var body: some View {
        VStack {
            HeaderView()
            
            titleView
            
            contentView
                .padding()
            
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
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack {
                    Text("symbol".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    Text("date".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    Text("currency".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)
                    
                    Text("type".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    Text("buy_qty".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)
                    
                    Text("sell_qty".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    Text("share_balance".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)
                    
                    Text("price".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)
                    
                    Text("buy_value".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)
                    
                    Text("sell_value".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    Text("total_cost".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    Text("share_cost".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)
                    
                    Text("sell_cost".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)
                    
                    Text("delay_pnl".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                    Text("pnl".localized)
                        .font(.apply(.semiBold,size:16))
                        .frame(minWidth: labelMinWidth, alignment: .leading)

                }
                .padding(4)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.colorBGPrimary)
                )
                .background(
                    RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.colorBorderSecondary,lineWidth: 1)
                )

                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(transactionSummaryData ?? [], id: \.id) { item in
                        HStack {
                            
                            // Symbol
                            Text("\(item.tickerID ?? "")")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)
                            
                            // Date
                            Text("\(formatDotNetDate(item.trDate ?? "") ?? "")")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)

                            // Currency
                            Text("\(item.shareCurrency ?? "")")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)
                            
                            // Type
                            Text("\(item.eDesc ?? "")")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)

                            
                            // buy qty (b_qty)
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.bQty ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)
                                .foregroundStyle(Color.colorPositive)

                            // sell qty (s_qty)
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.sQty ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)
                                .foregroundStyle(Color.colorNegative)

                            // Share Balance ()
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.bal ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)

                            // price ()
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.price ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)
                            
                            // Buy Value
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.bTotal ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)

                            // Sell Value
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.sTotal ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)
                            
                            // Total Cost
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.total ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)


                            // Share Cost
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.avCost ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)
                            
                            // Sell Cost
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.sellCost ?? 0))")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)

                            // Delay PnL
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.dResult ?? 0))%")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)


                            // Pnl
                            Text("\(AppUtility.shared.formatThousandSeparator(number: item.profit ?? 0))%")
                                .font(.apply(.semiBold,size:16))
                                .frame(minWidth: labelMinWidth, alignment: .leading)

                        }
                        .padding(4)
                        .padding(.horizontal, 2)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.colorBGPrimary)
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.colorBorderSecondary,lineWidth: 1)
                        )
                    }
                }
            }
            .padding(2)
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
