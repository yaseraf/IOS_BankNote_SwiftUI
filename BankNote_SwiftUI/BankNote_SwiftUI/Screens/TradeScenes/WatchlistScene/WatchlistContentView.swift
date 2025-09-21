//
//  WatchlistContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct WatchlistContentView: View {
    
    var watchlistData: Binding<[GetMarketWatchByProfileIDUIModel]?>

    var onBackTap:()->Void
    
    var body: some View {
        VStack(spacing: 6) {

            HeaderView()
            
            titleView
            
            watchlistView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .trade)
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
            
            Text("watchlist".localized)
                .font(.cairoFont(.bold, size: 32))
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
    
    private var watchlistView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(Array((watchlistData.wrappedValue ?? []).enumerated()), id: \.offset) { idnex, element in
                    WatchlistAllCell(watchlistData: element)
                }
            }
        }
    }

}

struct WatchlistAllCell: View {
    
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


#Preview {
    IndexContentView(indexData: .constant([]), onBackTap: {
        
    })
}
