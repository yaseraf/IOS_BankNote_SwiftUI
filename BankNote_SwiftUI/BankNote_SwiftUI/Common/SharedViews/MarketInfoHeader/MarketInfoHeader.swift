//
//  MarketInfoHeader.swift
//  QSC
//
//  Created by FIT on 18/02/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import SwiftUI

struct MarketInfoHeader: View {
    
    var body: some View{
        if UserDefaultController().priceAlertOption == true{
//            mainMarketInfo
//                .padding()
        }
        
    }
    
//    var mainMarketInfo: some View {
//        VStack{
//            ScrollView(.horizontal, showsIndicators: false){
//                HStack{
//                    ForEach(UserDefaultController().marketInfoHeaderTicker ?? [], id: \.id) { ticker in
//                        stockTag(stockName: ticker.symbol ?? "", lastTradePrice: ticker.lastTradePrice ?? "", netChangePerc: ticker.netChangePerc ?? "", isProfit: ticker.netChangePerc?.contains("-") ?? false ? false : true)
//                    }
//                }
//            }
//            .padding(.vertical, 4)
//            
//        }
//    }
    
    private func stockTag(stockName: String, lastTradePrice: String, netChangePerc: String, isProfit: Bool = false) -> some View {
        HStack{
            Text(stockName)
                .bold()
                .foregroundStyle(Color.colorTextPrimary)
                .padding(.trailing, 8)

            Text(AppUtility.shared.formatThousandSeparator(number: Double(lastTradePrice) ?? 0))
                .foregroundStyle(Color(hex: isProfit ? "#3595E9" : "#D92D20"))
                .padding(.trailing, 16)

            Image(isProfit ? "ic_upArrow" : "ic_downArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .padding(.trailing, 8)
            
            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(netChangePerc) ?? 0))%")
                .foregroundStyle(Color(hex: isProfit ? "#3595E9" : "#D92D20"))
                .padding(.trailing, 24)

        }
    }
}

struct MarketInfoHeaderNoTicker: View {
    
    var marketOpen: Bool
    @Binding var signalRConnected: Bool
    
    var body: some View{
        mainMarketInfoNoTicker
    }
    
    var mainMarketInfoNoTicker: some View {
        VStack{
            HStack{
                marketStatus()
    //                .font(.caption)
            }
        }
    }

    private func stockTag(stockName: String, netChange: String, netChangePerc: String, isProfit: Bool = false) -> some View {
        if isProfit {
            HStack{
                Text(stockName)
                    .bold()
                    .foregroundStyle(Color.colorTextPrimary)
                
                Text(netChange)
                    .foregroundStyle(Color(hex: "#3595E9"))
                
                Image("ic_upArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.horizontal, 4)
                
                Text("\(netChangePerc)%")
                    .foregroundStyle(Color(hex: "#3595E9"))
            }
        } else {
            HStack{
                Text(stockName)
                    .bold()
                    .foregroundStyle(Color.colorTextPrimary)
                
                Text(netChange)
                    .foregroundStyle(Color(hex: "#D92D20"))

                Image("ic_newDownArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.horizontal, 4)
                
                Text("\(netChangePerc)%")
                    .foregroundStyle(Color(hex: "#D92D20"))
            }
        }
       
    }

    private func marketStatus() -> some View {
        
        enum MarketStatus {
            case open
            case close
            case pending
        }
        
        var status: MarketStatus = .open
        
        if UserDefaultController().marketStatusCode == "0002" || UserDefaultController().marketStatusCode == "0003" {
            status = .open
        } else if UserDefaultController().marketStatusCode == "0004" || UserDefaultController().marketStatusCode == "0005" || UserDefaultController().marketStatusCode == nil {
            status = .close
        } else {
            status = .pending
        }
        
        return HStack{
            HStack{
                Image("egypt_flag")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
////                Text(marketOpen ? "Market opened" : "Market closed")
//                Text(AppUtility.shared.isRTL ? "\(AppUtility.shared.isRTL ? UserDefaultController().marketStatusTitleA ?? "closed".localized : UserDefaultController().marketStatusTitleE ?? "closed".localized) \("market".localized) " : "\("market".localized) \(AppUtility.shared.isRTL ? UserDefaultController().marketStatusTitleA ?? "closed".localized : UserDefaultController().marketStatusTitleE ?? "closed".localized)")
//                    .foregroundStyle(Color.colorTextPrimary)
//                    .font(.apply(size: 11))
                                  
                Circle()
                    .fill(status == .open ? Color.colorSuccess2 : status == .close ? Color.colorError : Color.colorWarning600)
                    .frame(width: 8)
                    .frame(height:  8)
            }
            
            
            Spacer()
            
            HStack{
                Image("ic_globe")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundStyle(signalRConnected ? Color.colorSuccess2 : Color.colorError)
                
                HStack{
                    Text("\(signalRConnected ? "connected".localized : "disconnected".localized)")
                        .foregroundStyle(signalRConnected ? Color.colorSuccess2 : Color.colorError)

                    Text("\(formattedDate())")
                }
                .font(.apply(size: 10))

            }
        }
    }

    func formattedDate() -> String {
            let formatter = DateFormatter()
        
            // Arabic AM/PM with English numbers
            if AppUtility.shared.isRTL {
                formatter.locale = Locale(identifier: "ar_SA@numbers=latn")
            } else {
                formatter.locale = Locale(identifier: "en_US")
            }
        
            formatter.dateFormat = "dd/MM/yyyy h:mm:ss a" // Correct format
            return formatter.string(from: Date())
    }
}

struct HeaderTime: View {
    var body: some View {
        HStack{
            Spacer()
            Text(formattedDate())
                .font(.apply(size: 11))
            Text(formattedDate())
                .font(.apply(size: 11))
        }
        .padding()

    }
}

func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy h:mm:ssa" // Correct format
        return formatter.string(from: Date())
}

//#Preview {
//    MarketInfoHeader()
//}
