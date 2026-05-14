//
//  OrderEntryContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct OrderEntryContentView: View {
    @State private var selectedTab: TradingType = .cash
    var isRiskManagementLoading:Binding<Bool>
    var cashInputValue:Binding<String>
    var stocksInputValue:Binding<String>
    var availableAmount:Binding<String?>
    var selectedOrderPriceType:Binding<OrderPriceType>
    var newMarketSymbol:Binding<GetALLMarketWatchBySymbolUIModel?>
    var orderDetails:Binding<OrderListUIModel?>
    var netChange:Binding<String>
    var netChangePerc:Binding<String>
    var lastTradePrice:Binding<String>
    var flagMessage:Binding<String>
    var isEditOrder:Binding<Bool>
    var placeOrderType:Binding<PlaceOrderType>
    
    private var isContinueEnabled: Bool { checkEnabledBtn() }

    @Binding var setPriceValue: String
    @State private var isSetPriceFocused: Bool = false
    @FocusState private var setPriceFocused: Bool
    @Binding var totalAmount: String

    var onMaxTap: () -> Void
    var onContinueTap: () -> Void
    var onValuesChange:() -> Void
    var onCashInputChange:() -> Void
    var onStocksInputChange:() -> Void
    var onBackTap: () -> Void
    

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                headerView
                
                orderPriceTypeView
                
                tradeView
                
                totalAmountCard(total: totalAmount)

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
        .onTapGesture {
            setPriceFocused = false
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
        VStack(spacing: 8) {
            
            // MARK: Row: Market Price | Limit Price | Set Price field
            HStack {
                // Market Price toggle
                if selectedOrderPriceType.wrappedValue == .market {
                    AppUtility.shared.APP_GRADIENT
                        .mask {
                            HStack(spacing: 6) {
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
                        onValuesChange()
                    } label: {
                        Text("market_price".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#828282"))
                    }
                }

                // Limit Price toggle
                if selectedOrderPriceType.wrappedValue == .limit {
                    AppUtility.shared.APP_GRADIENT
                        .mask {
                            HStack(spacing: 6) {
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
                        if isEditOrder.wrappedValue {
                            setPriceValue = orderDetails.wrappedValue?.Price ?? ""
                        }
                    } label: {
                        Text("limit_price".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#828282"))
                    }
                }

                Spacer()

                // MARK: Set Price Field — only visible in Limit mode
                if selectedOrderPriceType.wrappedValue == .limit {
                    setPriceField
                }
            }

            // MARK: Range bar — only in Limit mode
            if selectedOrderPriceType.wrappedValue == .limit {
                rangePriceBar
            }
        }
        .padding(.horizontal, 18)
    }

    // MARK: - Set Price Inline Field
    private var setPriceField: some View {
        HStack(spacing: 4) {
            // Gradient border pill
            ZStack {
                // Placeholder or value text with gradient
                HStack(spacing: 0) {
                    Text(setPriceValue.isEmpty ? "set_price".localized : setPriceValue)
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundColor(Color(hex: "#828282"))

                    // Blinking cursor — only when focused
                    if setPriceFocused {
                        Text("|")
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundColor(Color(hex: "#828282"))
                    }
                }
            }

            // Hidden TextField to capture keyboard input
            TextField("", text: $setPriceValue)
                .keyboardType(.decimalPad)
                .focused($setPriceFocused)
                .frame(width: 0, height: 0)
                .opacity(0)
                .onChange(of: setPriceValue) { newValue in
                    setPriceValue = newValue
                    onValuesChange()
                }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 99)
                .stroke(
                    LinearGradient(
                        colors: [Color(hex: "#629AF9"), Color(hex: "#FC814B")],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 1
                )
        )
        .contentShape(Rectangle())
        .onTapGesture {
            setPriceFocused = true
        }
    }
    // MARK: - Range Bar (extracted for clarity)
    private var rangePriceBar: some View {
        VStack(spacing: 0) {
            HStack {
                Text(AppUtility.shared.formatThousandSeparator(
                    number: Double(newMarketSymbol.wrappedValue?.minPrice ?? "") ?? 0))
                    .font(.cairoFont(.bold, size: 10))
                
                Spacer()
                
                Text(AppUtility.shared.formatThousandSeparator(
                    number: Double(newMarketSymbol.wrappedValue?.maxPrice ?? "") ?? 0))
                    .font(.cairoFont(.bold, size: 10))
            }
            .padding(.horizontal, 75)

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

                    AppUtility.shared.APP_GRADIENT
                        .mask {
                            RoundedRectangle(cornerRadius: 99)
                                .frame(maxWidth: .infinity)
                                .frame(height: 3)
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
    private var tradeView: some View {
        VStack(spacing: 0) {
            
            if placeOrderType.wrappedValue == .buy {
                HStack(spacing: 0) {
                    Button(action: { selectedTab = .cash }) {
                        Text("cash".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                            .padding(.vertical, 4)
                            .frame(maxWidth: 85)
                            .background(selectedTab == .cash ? placeOrderType.wrappedValue == .buy ? Color.colorPositive : Color.colorNegative /*Color(hex: "#9C4EF7")*/ : Color(hex: "#DDDDDD"))
                            .clipShape(Capsule())
                    }
                    .foregroundColor(selectedTab == .cash ? .white : Color(hex: "#828282"))
                    
                    Button(action: { selectedTab = .stocks }) {
                        Text("stocks".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                            .padding(.vertical, 4)
                            .frame(maxWidth: 85)
                            .background(selectedTab == .stocks ? placeOrderType.wrappedValue == .buy ? Color.colorPositive : Color.colorNegative /*Color(hex: "#9C4EF7")*/ : Color(hex: "#DDDDDD"))
                            .clipShape(Capsule())
                    }
                    .foregroundColor(selectedTab == .stocks ? .white : Color(hex: "#828282"))
                }
                .background(Color(hex: "#DDDDDD"))
                .clipShape(Capsule())
                
            } else {
                Text("stocks".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundColor(Color(hex: "#828282"))
                    .padding(.top, 4)
            }
            
            // MARK: Number display
            VStack(spacing: 0) {
                HStack(alignment: .firstTextBaseline, spacing:6) {
                    if placeOrderType.wrappedValue == .buy {
                        Text(selectedTab == .cash ? "egp".localized : "stocks".localized)
                            .font(.cairoFont(.bold, size: 32))
                        Text(selectedTab == .cash ? AppUtility.shared.formatThousandSeparatorNoDecimal(number: Double(cashInputValue.wrappedValue) ?? 0) : AppUtility.shared.formatThousandSeparatorNoDecimal(number: Double(stocksInputValue.wrappedValue) ?? 0))
                            .font(.cairoFont(.bold, size: 48))
                    } else {
                        Text("stocks".localized)
                            .font(.cairoFont(.bold, size: 32))
                        Text(AppUtility.shared.formatThousandSeparatorNoDecimal(number: Double(stocksInputValue.wrappedValue) ?? 0))
                            .font(.cairoFont(.bold, size: 48))
                    }
                }
                .foregroundStyle(Color(hex: "#828282"))
                
                // Error flag
                Text(flagMessage.wrappedValue)
                    .font(.cairoFont(.semiBold, size: 16))
                    .foregroundStyle(Color(hex: "#AA1A1A"))
                
                // MAX button
                Button(action: {
                    onMaxTap()
                }) {
                    Text("MAX")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 11)
                        .background(Color(hex: "#DDDDDD"))
                        .clipShape(RoundedRectangle(cornerRadius: 99))
                }
                .padding(.bottom, 10)
                
                Divider()
                
                // MARK: Bottom info — Buy shows Available Amount, Sell shows Total Stocks
                if placeOrderType.wrappedValue == .buy {
                    VStack(spacing: 4) {
                        Text("available_amount".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundColor(Color(hex: "#828282"))
                        Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(availableAmount.wrappedValue ?? "") ?? 0))")
                            .font(.cairoFont(.semiBold, size: 18))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 10)
                } else {
                    VStack(spacing: 4) {
                        Text("total_stocks".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundColor(Color(hex: "#828282"))
                        Text("\(AppUtility.shared.formatThousandSeparatorNoDecimal(number: Double(availableAmount.wrappedValue ?? "") ?? 0)) \("stocks".localized)")
                            .font(.cairoFont(.semiBold, size: 18))
                            .foregroundColor(.black)
                    }
                    .padding(.top, 10)
                }
            }

        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .padding(.vertical, 8)
        .padding(.horizontal, 18)
    }
    
    private func totalAmountCard(total: String) -> some View {
        HStack {
            Text("total_amount".localized)
                .font(.cairoFont(.semiBold, size: 14))
                .foregroundColor(Color(hex: "#828282"))

            Spacer()

            Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(total) ?? 0))")
                .font(.cairoFont(.semiBold, size: 14))
                .foregroundColor(.black)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 99).fill(.white))
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
                cashInputValue.wrappedValue = availableAmount.wrappedValue ?? ""
            } else if cashInputValue.wrappedValue == "0" && character != "." {
                // Replace the leading "0" with the new digit, unless it's a decimal point
                cashInputValue.wrappedValue = character
            } else {
                cashInputValue.wrappedValue += character
            }
            
            onCashInputChange()
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
                stocksInputValue.wrappedValue = availableAmount.wrappedValue ?? ""
            } else if stocksInputValue.wrappedValue == "0" && character != "." {
                // Replace the leading "0" with the new digit, unless it's a decimal point
                stocksInputValue.wrappedValue = character
            } else {
                stocksInputValue.wrappedValue += character
            }
            
            onStocksInputChange()
        }
    }

    private func keypadButton(character: String) -> some View {
        Button(action: {
            if (selectedTab == .cash && cashInputValue.wrappedValue.count > 8) {return}
            if (selectedTab == .stocks && stocksInputValue.wrappedValue.count > 8) {return}
            
            handleButtonTap(character)
//            onValuesChange()
        }) {
            Text(character)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 50)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
        }
//        .disabled(selectedTab == .cash && selectedOrderPriceType.wrappedValue == .market)
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
                .background(RoundedRectangle(cornerRadius: 99).fill(placeOrderType.wrappedValue == .buy ? Color.colorPositive : Color.colorNegative /*Color(hex: "#9C4EF7")*/))
        }
        .padding(.horizontal, 18)
        .disabled(!isContinueEnabled)
        .opacity(isContinueEnabled ? 1 : 0.3)
    }
    
    private func checkEnabledBtn() -> Bool {
        guard flagMessage.wrappedValue.isEmpty,
              !isRiskManagementLoading.wrappedValue else { return false }

        switch selectedOrderPriceType.wrappedValue {
        case .market:
            if selectedTab == .cash {
                return (Double(cashInputValue.wrappedValue) ?? 0) > 0
            } else {
                return (Double(stocksInputValue.wrappedValue) ?? 0) > 0
            }
        case .limit:
            let hasPrice = (Double(setPriceValue) ?? 0) > 0  // "Set Price" value
            let hasQuantity = (Double(stocksInputValue.wrappedValue) ?? 0) > 0
            return hasPrice && hasQuantity
        }
    }
}

//#Preview {
//    OrderEntryContentView(cashInputValue: .constant(""), stocksInputValue: .constant(""), availableAmount: .constant(""), selectedOrderPriceType: .constant(.limit), newMarketSymbol: .constant(.initializer()), orderDetails: .constant(.initializer()), netChange: .constant(""), netChangePerc: .constant(""), lastTradePrice: .constant(""), flagMessage: .constant(""), isEditOrder: .constant(false), onContinueTap: {
//        
//    }, onValuesChange: {
//        
//    }, onBackTap: {
//        
//    })
//}
