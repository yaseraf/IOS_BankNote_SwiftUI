//
//  IndexContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct IndexContentView: View {
    
    var indexData: Binding<[IndexUIModel]?>
    
    var onBackTap:()->Void
    
    var body: some View {
        VStack(spacing: 6) {

            HeaderView()
            
            titleView
            
            indexView
            
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
            
            Text("index".localized)
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
    
    private var indexView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(Array((indexData.wrappedValue ?? []).enumerated()), id: \.offset) { idnex, element in
                    IndexAllCell(indexData: element)
                }
            }
        }
    }

}

struct IndexAllCell: View {
    
    var indexData: IndexUIModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Image(indexData.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                
                Text("\(indexData.name ?? "")")
                    .font(.cairoFont(.semiBold, size: 14))
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(indexData.changePerc ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(indexData.changePerc ?? 0 >= 0 ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: indexData.changePerc ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: indexData.changePerc ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
                }

                VStack(alignment: .leading, spacing: 0) {
                    
                }
            }
            
            HStack {
                Text("\(AppUtility.shared.formatThousandSeparator(number: indexData.value ?? 0)) \("points".localized)")
                    .font(.cairoFont(.semiBold, size: 18))
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}


#Preview {
    IndexContentView(indexData: .constant([IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 30", changePerc: 0.016, value: 2262.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 70", changePerc: -0.20, value: 9550.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43), IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43)]), onBackTap: {
        
    })
}
