//
//  IndexContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct IndexDetailsContentView: View {
    
    var title: Binding<String?>
    var marketWatchData: Binding<[GetMarketWatchByProfileIDUIModel]?>
    var onWatchlistTap:(GetMarketWatchByProfileIDUIModel)->Void

    var onBackTap:()->Void
    
    @State private var searchText: String = ""
    @State private var isSearchVisible: Bool = false
    @FocusState private var isSearchFocused: Bool
    
    private var filteredData: [GetMarketWatchByProfileIDUIModel] {
        let data = marketWatchData.wrappedValue ?? []
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return data
        }
        return data.filter { item in
            let nameAr = item.symbolNameArabic ?? ""
            let nameEn = item.symbolNameEnglish ?? ""
            let symbol = item.symbol ?? ""
            let query = searchText.lowercased()
            return nameAr.lowercased().contains(query)
                || nameEn.lowercased().contains(query)
                || symbol.lowercased().contains(query)
        }
    }
    
    var body: some View {
        VStack(spacing: 6) {

            HeaderView()
            
            titleView
            
            if isSearchVisible {
                searchBarView
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            watchlistView
            
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
            
            Text("\(title.wrappedValue ?? "") \("companies".localized)")
                .font(.cairoFont(.bold, size: 32))
                .foregroundStyle(.black)

            Spacer()

            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isSearchVisible.toggle()
                    if !isSearchVisible {
                        searchText = ""
                        isSearchFocused = false
                    } else {
                        // Slight delay so the field appears before focus
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isSearchFocused = true
                        }
                    }
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.gray)
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
            }
        }
        .padding(.horizontal, 18)
    }
    
    private var searchBarView: some View {
        HStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
                    .frame(width: 18, height: 18)
                
                TextField("search_symbol".localized, text: $searchText)
                    .font(.cairoFont(.regular, size: 14))
                    .focused($isSearchFocused)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            
            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    searchText = ""
                    isSearchVisible = false
                    isSearchFocused = false
                }
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.white)
                    .padding(10)
                    .background(Circle().fill(Color(.systemGray3)))
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 4)
    }
    
    private var watchlistView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(filteredData, id: \.id) { item in
                    Button {
                        onWatchlistTap(item)
                    } label: {
                        WatchlistAllCell(watchlistData: item)
                    }
                    .buttonStyle(.plain)
                }
                
                if filteredData.isEmpty && !searchText.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 40))
                            .foregroundStyle(Color(.systemGray3))
                        Text(String(format: "no_results_for".localized, searchText))
                            .font(.cairoFont(.semiBold, size: 14))
                            .foregroundStyle(Color(.systemGray))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 60)
                }
            }
            .padding(.top, 4)
        }
    }


}
