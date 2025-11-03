//
//  SelectPriceFactorContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
import SwiftUI

struct SelectPriceFactorContentView: View {
    
    var priceFactors:Binding<[PriceFactorUIModel]?>
    @State var selectedPriceFactor:PriceFactorUIModel?
    
    enum PriceFactors {
        case theHighestPrice
        case lastPrice
        case averagePrice
        case totalQuantity
        case lowerPrice
        
        var id: Int {
            switch self {
            case .theHighestPrice: return 0
            case .lastPrice: return 1
            case .averagePrice: return 2
            case .totalQuantity: return 3
            case .lowerPrice: return 4
            }
        }
    }
    
    var onDismiss:() -> Void
    var onConfirm:(PriceFactorUIModel) -> Void
    
    var body: some View {
        VStack {
            headerView
            
            contentView
            
            Spacer()
            
            bottomButtonView
        }
    }
    
    private var headerView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.colorBorder)
                .frame(maxWidth: 46, maxHeight: 4)
                .padding(.top, 16)
                .padding(.bottom, 8)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("price_selection".localized)
                    .font(.apply(.medium, size: 16))
                
                Spacer()
                
                Circle()
                    .fill(Color.colorBG)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image("ic_close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .background(Circle().stroke(lineWidth: 1).fill(Color.colorBorder))
                    .onTapGesture {
                        onDismiss()
                    }
            }
            .padding(.horizontal, 24)
        }
    }

    private var contentView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("the_highest_price".localized)
                    .font(.apply(.regular, size: 16))
                Spacer()
                Image(selectedPriceFactor?.factorId == PriceFactors.theHighestPrice.id ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                selectedPriceFactor = PriceFactorUIModel(factorId: 0, factorName: "the_highest_price")
            }
            Divider()
            
            HStack {
                Text("last_price".localized)
                    .font(.apply(.regular, size: 16))
                Spacer()
                Image(selectedPriceFactor?.factorId == PriceFactors.lastPrice.id ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                selectedPriceFactor = PriceFactorUIModel(factorId: 1, factorName: "last_price")
            }
            Divider()
            
            HStack {
                Text("average_price".localized)
                    .font(.apply(.regular, size: 16))
                Spacer()
                Image(selectedPriceFactor?.factorId == PriceFactors.averagePrice.id ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                selectedPriceFactor = PriceFactorUIModel(factorId: 2, factorName: "average_price")
            }
            Divider()
            
            HStack {
                Text("total_quantity".localized)
                    .font(.apply(.regular, size: 16))
                Spacer()
                Image(selectedPriceFactor?.factorId == PriceFactors.totalQuantity.id ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                selectedPriceFactor = PriceFactorUIModel(factorId: 3, factorName: "total_quantity")
            }
            Divider()
            
            HStack {
                Text("lower_price".localized)
                    .font(.apply(.regular, size: 16))
                Spacer()
                Image(selectedPriceFactor?.factorId == PriceFactors.lowerPrice.id ? "ic_checkmarkBlue" : "ic_checkmarkEmpty")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .onTapGesture {
                selectedPriceFactor = PriceFactorUIModel(factorId: 3, factorName: "lower_price")
            }
            Divider()

            
        }
        .padding(.horizontal, 16)
    }
    
    private var bottomButtonView: some View {
        Text("confirm".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(.white)
            .frame(minHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onConfirm(selectedPriceFactor ?? .initializer())
            }
    }


}
