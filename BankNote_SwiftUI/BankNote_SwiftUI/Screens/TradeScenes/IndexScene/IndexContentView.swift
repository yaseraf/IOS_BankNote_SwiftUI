//
//  IndexContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct IndexContentView: View {
    
    var indexData: Binding<[GetExchangeSummaryUIModel]?>

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
    
    var indexData: GetExchangeSummaryUIModel
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Image("ic_indexPlaceholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)


                Text("\(indexData.eMName ?? "")")
                    .font(.cairoFont(.semiBold, size: 14))
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(Double(indexData.netChangePerc ?? "") ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(Double(indexData.netChangePerc ?? "") ?? 0 >= 0 ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: Double(indexData.netChangePerc ?? "") ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: Double(indexData.netChangePerc ?? "") ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
                }

                VStack(alignment: .leading, spacing: 0) {
                    
                }
            }
            
            HStack {
                Text("\(AppUtility.shared.formatThousandSeparator(number: Double(indexData.currentValue ?? "") ?? 0)) \("points".localized)")
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
    IndexContentView(indexData: .constant([]), onBackTap: {
        
    })
}
