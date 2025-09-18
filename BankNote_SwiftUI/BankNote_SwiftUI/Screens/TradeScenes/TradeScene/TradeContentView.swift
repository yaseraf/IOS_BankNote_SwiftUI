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
    var watchlistData: Binding<[GetAllProfilesLookupsByUserCodeUIModel]?>
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
    
    var watchlistData: GetAllProfilesLookupsByUserCodeUIModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(portfolioData.symbol ?? "").png")) { phase in
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
                    Text("\(watchlistData.name ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\(watchlistData.fullName ?? "")")
                        .font(.cairoFont(.semiBold, size: 12))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: watchlistData.change ?? 0))")
                    .font(.cairoFont(.semiBold, size: 12))

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
    TradeContentView(indexData: .constant([]), watchlistData: .constant([]), newsData: .constant([]), onIndexViewAllTap: {
        
    }, onWatchlistViewAllTap: {
        
    }, onNewsViewAllTap: {
        
    })
}
