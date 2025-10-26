//
//  OrderEntryContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

enum TradingType {
    case cash
    case stocks
}

enum OrderPriceType {
    case market
    case limit
}

struct OrderEntryContentView: View {
    @State private var selectedTab: TradingType = .cash
    var cashInputValue:Binding<String>
    var stocksInputValue:Binding<String>
    @State private var availableAmount: Int = 1000
    var selectedOrderPriceType:Binding<OrderPriceType>
    var newMarketSymbol:Binding<GetALLMarketWatchBySymbolUIModel?>
    var orderDetails:Binding<OrderListUIModel?>
    var netChange:Binding<String>
    var netChangePerc:Binding<String>
    var lastTradePrice:Binding<String>
    var flagMessage:Binding<String>
    var isEditOrder:Binding<Bool>
    
    var onContinueTap: () -> Void
    var onValuesChange:() -> Void
    var onBackTap: () -> Void
    

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                headerView
                
                orderPriceTypeView
                
                tradeView
                
                Spacer()

                VStack(spacing: 12) {
                    HStack(spacing: 10) {
                        keypadButton(character: "1")
                        keypadButton(character: "2")
                        keypadButton(character: "3")
                    }
                    HStack(spacing: 10) {
                        keypadButton(character: "4")
                        keypadButton(character: "5")
                        keypadButton(character: "6")
                    }
                    HStack(spacing: 10) {
                        keypadButton(character: "7")
                        keypadButton(character: "8")
                        keypadButton(character: "9")
                    }
                    HStack(spacing: 10) {
                        keypadButton(character: ".")
                            .disabled(selectedTab == .stocks)
                        keypadButton(character: "0")
                        backspaceButton()
                    }
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 10)


                bottomButtonView
                
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    onBackTap()
                } label: {
                    Image("ic_leftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }

                
                Spacer()
            }
            
            HStack {
                HStack(spacing: 16) {
                    WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(UserDefaultController().selectedSymbol ?? "").png")) { phase in
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
                        Text("\(UserDefaultController().selectedSymbol ?? "")")
                            .font(.cairoFont(.semiBold, size: 18))

                        HStack{
                            Image("ic_topUp")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color(hex: "#1E961E"))
                            
                            Text("\(Double(netChangePerc.wrappedValue) ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(netChangePerc.wrappedValue) ?? 0))% (\("egp".localized) \(Double(netChange.wrappedValue) ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(netChange.wrappedValue) ?? 0)))")
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(Color(hex: "#1E961E"))
                            
                        }

                    }
                }
                
                Spacer()
                
                HStack(alignment: .firstTextBaseline, spacing:0) {
                    Text("\("egp".localized)")
                        .font(.cairoFont(.semiBold, size: 12))

                    Text(AppUtility.shared.formatThousandSeparator(number: Double(lastTradePrice.wrappedValue) ?? 0))
                        .font(.cairoFont(.semiBold, size: 18))

                }
                    
            }
            .padding(18)

        }
    }
    
    private var orderPriceTypeView: some View {
        VStack {
            HStack {
                if selectedOrderPriceType.wrappedValue == .market {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .mask {
                        HStack(spacing: 6){
                            Circle()
                                .frame(width: 5, height: 5)
                            
                            Text("market_price".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                        }
                    }
                    .frame(maxWidth: 100)
                } else {
                    Button {
                        selectedOrderPriceType.wrappedValue = .market
//                        cashInputValue.wrappedValue = "0"
                        onValuesChange()
                    } label: {
                        Text("market_price".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#828282"))
                    }
                }

                if selectedOrderPriceType.wrappedValue == .limit {
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .mask {
                        HStack(spacing: 6){
                            Circle()
                                .frame(width: 5, height: 5)
                            
                            Text("limit_price".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                        }
                    }
                    .frame(maxWidth: 100)
                } else {
                    Button {
                        selectedOrderPriceType.wrappedValue = .limit
                        if isEditOrder.wrappedValue == true {
                            cashInputValue.wrappedValue = orderDetails.wrappedValue?.Price ?? ""
                        }
                    } label: {
                        Text("limit_price".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#828282"))
                    }
                }

                
                Spacer()
            }
            
            VStack(spacing: 0) {
                HStack {
                    Text(AppUtility.shared.formatThousandSeparator(number: Double(newMarketSymbol.wrappedValue?.minPrice ?? "") ?? 0))
                        .font(.cairoFont(.bold, size: 10))
                    
                    Spacer()

                    
                    Text(AppUtility.shared.formatThousandSeparator(number: Double(newMarketSymbol.wrappedValue?.maxPrice ?? "") ?? 0))
                        .font(.cairoFont(.bold, size: 10))

                }
                .padding(.horizontal, 75)
                .frame(maxWidth: .infinity)

                ZStack {
                    RoundedRectangle(cornerRadius: 99)
                        .frame(maxWidth: .infinity)
                        .frame(height: 3)
                        .foregroundStyle(Color(hex: "#D9D9D9"))
                    
                    HStack(spacing: -2) {
                        Circle()
                            .frame(width: 7, height: 7)
                            .foregroundStyle(Color(hex: "#629AF9"))
                            .zIndex(1)

                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .mask {
                            RoundedRectangle(cornerRadius: 99)
                                .frame(maxWidth: .infinity)
                                .frame(height: 3)
                                .foregroundStyle(Color(hex: "#000000"))

                        }
                        .zIndex(0)
                        
                        Circle()
                            .frame(width: 7, height: 7)
                            .foregroundStyle(Color(hex: "#FC814B"))
                            .zIndex(1)

                    }
                    .padding(.horizontal, 85)
                }

            }

        }
        .padding(.horizontal, 18)
    }
    
    private var tradeView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button(action: { selectedTab = .cash }) {
                    Text("cash".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .padding(.vertical, 4)
                        .frame(maxWidth: 85)
                        .background(selectedTab == .cash ? Color(hex: "#9C4EF7") : Color(hex: "#DDDDDD"))
                        .clipShape(Capsule())
                }
                .foregroundColor(selectedTab == .cash ? .white : Color(hex: "#828282"))
                
                Button(action: { selectedTab = .stocks }) {
                    Text("stocks".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .padding(.vertical, 4)
                        .frame(maxWidth: 85)
                        .background(selectedTab == .stocks ? Color(hex: "#9C4EF7") : Color(hex: "#DDDDDD"))
                        .clipShape(Capsule())
                }
                .foregroundColor(selectedTab == .stocks ? .white : Color(hex: "#828282"))
            }
            .background(Color(hex: "#DDDDDD"))
            .clipShape(Capsule())


            VStack(spacing: 0) {
                HStack(alignment: .firstTextBaseline, spacing:6) {
                    Text(selectedTab == .cash ? "egp".localized : "stocks".localized)
                        .font(.cairoFont(.bold, size: 32))
                    Text(selectedTab == .cash && selectedOrderPriceType.wrappedValue == .market ? "MKT" : selectedTab == .cash ? AppUtility.shared.formatThousandSeparatorNoDecimal(number: Double(cashInputValue.wrappedValue) ?? 0) : AppUtility.shared.formatThousandSeparatorNoDecimal(number: Double(stocksInputValue.wrappedValue) ?? 0))
                        .font(.cairoFont(.bold, size: 48))
                }
                .foregroundStyle(Color(hex: "#828282"))
                
                Text(flagMessage.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 16))
                    .foregroundStyle(Color(hex: "#AA1A1A"))

                
                Button(action: { handleButtonTap("MAX") }) {
                    Text("MAX")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 11)
                        .background(Color(hex: "#DDDDDD"))
                        .clipShape(RoundedRectangle(cornerRadius: 99))
                }
                .padding(.bottom, 10)
                
                Divider()
                
                VStack {
                    Text("available_amount".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    Text("\("egp".localized) \(availableAmount)")
                        .font(.cairoFont(.semiBold, size: 18))
                }
                .padding(.top, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .padding(.vertical, 8)
        .padding(.horizontal, 18)

    }
    
    private func handleButtonTap(_ character: String) {
        if selectedTab == .cash {
            if character == "⌫" {
                // Remove the last character, unless it's the last one and it's not "0"
                if cashInputValue.wrappedValue.count > 1 {
                    cashInputValue.wrappedValue.removeLast()
                } else if cashInputValue.wrappedValue != "0" {
                    cashInputValue.wrappedValue = "0"
                }
            } else if character == "." {
                // Only allow one decimal point
                if !cashInputValue.wrappedValue.contains(".") {
                    cashInputValue.wrappedValue += character
                }
            } else if character == "MAX" {
                // Set the input to the maximum available amount
                cashInputValue.wrappedValue = String(availableAmount)
            } else if cashInputValue.wrappedValue == "0" && character != "." {
                // Replace the leading "0" with the new digit, unless it's a decimal point
                cashInputValue.wrappedValue = character
            } else {
                cashInputValue.wrappedValue += character
            }
        } else {
            if character == "⌫" {
                // Remove the last character, unless it's the last one and it's not "0"
                if stocksInputValue.wrappedValue.count > 1 {
                    stocksInputValue.wrappedValue.removeLast()
                } else if stocksInputValue.wrappedValue != "0" {
                    stocksInputValue.wrappedValue = "0"
                }
            } else if character == "." {
                // Only allow one decimal point
                if !stocksInputValue.wrappedValue.contains(".") {
                    stocksInputValue.wrappedValue += character
                }
            } else if character == "MAX" {
                // Set the input to the maximum available amount
                stocksInputValue.wrappedValue = String(availableAmount)
            } else if stocksInputValue.wrappedValue == "0" && character != "." {
                // Replace the leading "0" with the new digit, unless it's a decimal point
                stocksInputValue.wrappedValue = character
            } else {
                stocksInputValue.wrappedValue += character
            }
        }
    }

    private func keypadButton(character: String) -> some View {
        Button(action: {
            if (selectedTab == .cash && cashInputValue.wrappedValue.count > 8) {return}
            if (selectedTab == .stocks && stocksInputValue.wrappedValue.count > 8) {return}
            
            handleButtonTap(character)
            onValuesChange()
        }) {
            Text(character)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 50)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
        }
        .disabled(selectedTab == .cash && selectedOrderPriceType.wrappedValue == .market)
    }
    
    private func backspaceButton() -> some View {
        Button(action: {
            handleButtonTap("⌫")
            onValuesChange()
        }) {
            ZStack {
                Image("ic_erase")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            .padding(.vertical, 14)
            .frame(maxWidth: 112, maxHeight: 54)
            .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
        }
    }
    
    private var bottomButtonView: some View {
        Button(action: {
            onContinueTap()
        }) {
            Text("Continue")
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 54)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
        }
        .padding(.horizontal, 18)
        .disabled(!checkEnabledBtn())
        .opacity(checkEnabledBtn() ? 1 : 0.3)
    }
    
    private func checkEnabledBtn() -> Bool {
        if Double(stocksInputValue.wrappedValue) ?? 0 > 0 && ((Double(cashInputValue.wrappedValue) ?? 0 > 0 && selectedOrderPriceType.wrappedValue == .limit) || (selectedOrderPriceType.wrappedValue == .market)) && flagMessage.wrappedValue.isEmpty {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    OrderEntryContentView(cashInputValue: .constant(""), stocksInputValue: .constant(""), selectedOrderPriceType: .constant(.limit), newMarketSymbol: .constant(.initializer()), orderDetails: .constant(.initializer()), netChange: .constant(""), netChangePerc: .constant(""), lastTradePrice: .constant(""), flagMessage: .constant(""), isEditOrder: .constant(false), onContinueTap: {
        
    }, onValuesChange: {
        
    }, onBackTap: {
        
    })
}
