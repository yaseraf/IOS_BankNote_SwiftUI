//
//  TradeContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
import SwiftUI

struct TradeContentView: View {
    var indexData: Binding<[IndexUIModel]?>
    var watchlistData: Binding<[WatchlistUIModel]?>
    var newsData: Binding<[NewsUIModel]?>
    
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
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array((watchlistData.wrappedValue ?? []).enumerated()), id: \.offset) { idnex, element in
                    WatchlistCell(watchlistData: element)
                }
            }
            
        }
    }
    
    private var newsView: some View {
        VStack {
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
                Text(selectedNewsType == .all ? "\("•" + " " + "all".localized)" : "all".localized)
                    .font(.cairoFont(.regular, size: 18))
                    .foregroundStyle(selectedNewsType == .all ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                    .onTapGesture {
                        selectedNewsType = .all
                    }
                Text(selectedNewsType == .stocks ? "\("•" + " "  + "stocks".localized)" : "stocks".localized)
                    .font(.cairoFont(.regular, size: 18))
                    .foregroundStyle(selectedNewsType == .stocks ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                    .onTapGesture {
                        selectedNewsType = .stocks
                    }
                Text(selectedNewsType == .markets ? "\("•" + " "  + "markets".localized)" : "markets".localized)
                    .font(.cairoFont(.regular, size: 18))
                    .foregroundStyle(selectedNewsType == .markets ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                    .onTapGesture {
                        selectedNewsType = .markets
                    }
                
                Spacer()

            }
            .padding(.horizontal, 18)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array((newsData.wrappedValue ?? []).enumerated()), id: \.offset) { index, element in
                    newsCell(newsData: element)
                        .padding(.horizontal, 26)
                    if index < (newsData.wrappedValue?.count ?? 0) - 1 {
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

struct IndexCell: View {
    
    var indexData: IndexUIModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(indexData.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(indexData.name ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\(AppUtility.shared.formatThousandSeparator(number: indexData.value ?? 0)) \("points".localized)")
                        .font(.cairoFont(.semiBold, size: 12))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 4) {
                    Image(indexData.changePerc ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(indexData.changePerc ?? 0 >= 0 ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: indexData.changePerc ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: indexData.changePerc ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
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
    
    var watchlistData: WatchlistUIModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(watchlistData.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(watchlistData.name ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\(watchlistData.fullName ?? "")")
                        .font(.cairoFont(.semiBold, size: 12))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: watchlistData.change ?? 0))")
                
                HStack(spacing: 4) {
                    Image(watchlistData.changePerc ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(watchlistData.changePerc ?? 0 >= 0 ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: watchlistData.changePerc ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: watchlistData.changePerc ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
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
    
    var newsData: NewsUIModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(newsData.indexName ?? "")
                    .font(.cairoFont(.light, size: 12))
                    .foregroundStyle(.black)

                Text("•")
                
                Text(newsData.time ?? "")
                    .font(.cairoFont(.light, size: 12))
                    .foregroundStyle(.black)
            }
            
            Text(newsData.title ?? "")
                .font(.cairoFont(.semiBold, size: 14))

            Text(newsData.desc ?? "")
                .font(.cairoFont(.medium, size: 14))

        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    TradeContentView(indexData: .constant([IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 30", changePerc: 0.016, value: 2262.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 70", changePerc: -0.20, value: 9550.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43)]), watchlistData: .constant([WatchlistUIModel(image: "ic_fawry", name: "FWRY", fullName: "Fawry For Banking Technology", change: 35, changePerc: 3.01), WatchlistUIModel(image: "ic_etel", name: "ETEL", fullName: "Telecom Egypt", change: 35, changePerc: -2.1)]), newsData: .constant([NewsUIModel(indexName: "EGX", time: "2 hours ago", title: "ADNOC Distribution Expands to Saudi Arabia", desc: "ADNOCDIST announces new fuel stations in KSA as..."), NewsUIModel(indexName: "EGX", time: "Yesterday", title: "Emaar Properties Reports 12% Profit Growth in Q1 2025", desc: "Strong performance driven by Dubai’s real estate..."), NewsUIModel(indexName: "EGX", time: "3 days ago", title: "UAE Central Bank Holds Interest Rates Steady", desc: "Decision aligns with US Fed Pol policy amid stable ...")]), onIndexViewAllTap: {
        
    }, onWatchlistViewAllTap: {
        
    }, onNewsViewAllTap: {
        
    })
}
