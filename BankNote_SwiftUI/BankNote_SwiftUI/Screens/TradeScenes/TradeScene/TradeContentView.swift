//
//  TradeContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct TradeContentView: View {
    var indexData: Binding<[GetExchangeSummaryUIModel]?>
    var watchlistData: Binding<[GetMarketWatchByProfileIDUIModel]?>
    var newsData: Binding<[GetAllMarketNewsUIModel]?>
    
    enum SelectedNewsType {
        case all
        case stocks
        case markets
    }
    
    @State var selectedNewsType: SelectedNewsType = .all
    
    var onIndexViewAllTap:()->Void
    var onWatchlistViewAllTap:()->Void
    var onNewsViewAllTap:()->Void
    
    
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollView(.vertical, showsIndicators: false) {
                indexView
                    .padding(.bottom, 32)
                
                watchlistView
                    .padding(.bottom, 32)
                
                newsView
            }
            
            HomeBottomBarView(selectedItem: .trade)

            Spacer()
        }
    }
        
    private var indexView: some View {
        VStack {
            HStack {
                Text("index".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    onIndexViewAllTap()
                } label: {
                    Text("view_all".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(RoundedRectangle(cornerRadius: 99).fill(.white))
                }

            }
            .padding(.horizontal, 18)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array((indexData.wrappedValue ?? []).enumerated()), id: \.offset) { idnex, element in
                    IndexCell(indexData: element)
                }
            }
        }
    }
    
    private var watchlistView: some View {
        VStack {
            HStack {
                Text("watchlist".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    onWatchlistViewAllTap()
                } label: {
                    Text("view_all".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(RoundedRectangle(cornerRadius: 99).fill(.white))
                }
            }
            .padding(.horizontal, 18)
            
            if watchlistData.wrappedValue?.isEmpty == false {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0...3, id: \.self) { id in
                        WatchlistCell(watchlistData: watchlistData.wrappedValue?[id] ?? .initializer())
                    }
                }
            }
            
        }
    }
    
    private var newsView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("news".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Button {
                    onNewsViewAllTap()
                } label: {
                    Text("view_all".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(RoundedRectangle(cornerRadius: 99).fill(.white))
                }
            }
            .padding(.horizontal, 18)
            
            HStack {
                HStack(alignment: .center, spacing: 6){
                    if selectedNewsType == .all {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                    }
                    Text("all".localized)
                        .font(.cairoFont(.regular, size: 18))
                        .foregroundStyle(selectedNewsType == .all ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                        .onTapGesture {
                            selectedNewsType = .all
                        }
                }
                HStack(alignment: .center, spacing: 6){
                    if selectedNewsType == .stocks {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                    }
                    Text("stocks".localized)
                        .font(.cairoFont(.regular, size: 18))
                        .foregroundStyle(selectedNewsType == .stocks ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                        .onTapGesture {
                            selectedNewsType = .stocks
                        }
                }
                HStack(alignment: .center, spacing: 6){
                    if selectedNewsType == .markets {
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                    }
                    Text("markets".localized)
                        .font(.cairoFont(.regular, size: 18))
                        .foregroundStyle(selectedNewsType == .markets ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                        .onTapGesture {
                            selectedNewsType = .markets
                        }
                }
                
                Spacer()

            }
            .padding(.horizontal, 18)
        
            if newsData.wrappedValue?.isEmpty == false {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0...3, id: \.self) { id in
                        newsCell(newsData: newsData.wrappedValue?[id] ?? .initializer())
                            .padding(.horizontal, 26)
                        if id < 3 {
                            Divider()
                        }
                    }
                    .padding(.vertical, 17)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                    .padding(.horizontal, 18)
                }
                .lineSpacing(CGFloat.zero)
            }
        }
    }
}

struct IndexCell: View {
    
    var indexData: GetExchangeSummaryUIModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                Image("ic_indexPlaceholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(indexData.eMName ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(indexData.currentValue ?? "") ?? 0)) \("points".localized)")
                        .font(.cairoFont(.semiBold, size: 12))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 4) {
                    Image(Double(indexData.netChangePerc ?? "") ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(Double(indexData.netChangePerc ?? "") ?? 0 >= 0 ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: Double(indexData.netChangePerc ?? "") ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: Double(indexData.netChangePerc ?? "") ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}

struct WatchlistCell: View {
    
    var watchlistData: GetMarketWatchByProfileIDUIModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(watchlistData.symbol).png")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .padding(.horizontal, 4)
                            .foregroundStyle(.gray)
                    case .failure:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .padding(.horizontal, 4)
                            .foregroundStyle(.gray)
                    case .empty:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .foregroundStyle(.gray)
                    @unknown default:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .foregroundStyle(.gray) 
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(AppUtility.shared.isRTL ? watchlistData.symbolNameA ?? "" : watchlistData.symbolNameE ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\(AppUtility.shared.isRTL ? watchlistData.symbolNameA ?? "" : watchlistData.symbolNameE ?? "")")
                        .font(.cairoFont(.semiBold, size: 12))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(watchlistData.netChange ?? "") ?? 0))")
                    .font(.cairoFont(.semiBold, size: 12))

                HStack(spacing: 4) {
                    Image(Double(watchlistData.netChangePerc ?? "") ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(Double(watchlistData.netChangePerc ?? "") ?? 0 >= 0 ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: Double(watchlistData.netChangePerc ?? "") ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: Double(watchlistData.netChangePerc ?? "") ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}

struct newsCell: View {
    
    var newsData: GetAllMarketNewsUIModel
    
    func getHourOfTimeStamp(from dateString: String) -> String {
        // Define the date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        dateFormatter.timeZone = TimeZone.current

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy" // Desired output format

        if let date = dateFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    func getNewsContent(description: String, symbol: String) -> String {
                
        if let rangeStart = description.range(of: "<a"),
           let rangeEnd = description.range(of: "</a>", range: rangeStart.upperBound..<description.endIndex) {
            let content = description[rangeStart.upperBound..<rangeEnd.lowerBound]
            let filter1 = description.replacingOccurrences(of: "<br />", with: "")
            let filter2 = filter1.replacingOccurrences(of: content, with: "")
            let filter3 = filter2.replacingOccurrences(of: "<a</a>", with: "")
            let filter4 = filter3.replacingOccurrences(of: "<br>", with: "")
//            let filter4 = filter3.replacingOccurrences(of: "Company:", with: "")
                return String(filter4)
            }
        return "Symbol Name: \(symbol)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Text("egx".localized)
                    .font(.cairoFont(.light, size: 12))
                    .foregroundStyle(.black)

                Text("•")
                
                Text(getHourOfTimeStamp(from: newsData.newsDate ?? ""))
                    .font(.cairoFont(.light, size: 12))
                    .foregroundStyle(.black)
            }
            
            Text("\(getNewsContent(description: AppUtility.shared.isRTL ? newsData.newsDescA ?? "" : newsData.newsDescE ?? "", symbol: newsData.symbol ?? ""))")
                .font(.cairoFont(.semiBold, size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    TradeContentView(indexData: .constant([]), watchlistData: .constant([]), newsData: .constant([]), onIndexViewAllTap: {
        
    }, onWatchlistViewAllTap: {
        
    }, onNewsViewAllTap: {
        
    })
}
