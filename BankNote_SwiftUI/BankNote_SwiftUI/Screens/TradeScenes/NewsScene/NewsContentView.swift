//
//  NewsContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct NewsContentView: View {
    
    var newsData:Binding<[GetAllMarketNewsUIModel]?>
    
    enum SelectedNewsType {
        case all
        case stocks
        case markets
    }
    
    @State var selectedNewsType: SelectedNewsType = .all
    var onBackTap:()->Void

    var body: some View {
        VStack(spacing: 6) {

            HeaderView()
            
            titleView
            
            newsView
            
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
            
            Text("news".localized)
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

    
    private var newsView: some View {
        VStack {
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

struct newsAllCell: View {
    
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
