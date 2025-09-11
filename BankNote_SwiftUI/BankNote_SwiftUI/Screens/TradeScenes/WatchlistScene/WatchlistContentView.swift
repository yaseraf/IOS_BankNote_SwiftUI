//
//  WatchlistContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct WatchlistContentView: View {
    
    var watchlistData: Binding<[WatchlistUIModel]?>
    
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


#Preview {
    IndexContentView(indexData: .constant([IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 30", changePerc: 0.016, value: 2262.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 70", changePerc: -0.20, value: 9550.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43)]), onBackTap: {
        
    })
}
