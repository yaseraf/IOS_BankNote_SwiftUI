//
//  PaymentMethodContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI

struct PaymentMethodContentView: View {
    
    @State private var selectedMethod: PaymentMethod = .debitCard
    @State private var selectedCard: String = "**** - **** - **** - 1234"
    @State private var totalAmount: Double = 0.0
    
    var onBackTap:()->Void
    var onPayTap:()->Void
    
    var body: some View {
        VStack {
            headerView
            
            dismissView
            
            titleView
            
            paymentMethodSelectionView
            
            Spacer()
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(spacing: 0) {
                Image("ic_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Text("BANKNOTE")
                    .font(.cairoFont(.extraBold, size: 14))
            }
            
            Spacer()
            
            Circle()
                .fill(.white)
                .frame(width: 40, height: 40)
                .overlay(
                    Image("ic_notification")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                )
        }
        .padding(.horizontal, 18)
    }
    
    private var dismissView: some View {
        Button(action: {
            onBackTap()
        }) {
            HStack {
                Image("ic_close")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
            
                Spacer()
            }
            .padding(.horizontal, 18)
        }
    }
    
    private var titleView: some View {
        Text("payment_method".localized)
            .font(.cairoFont(.bold, size: 32))
    }
    
    private var paymentMethodSelectionView: some View {
        
        var addNewCardAttribute: AttributedString {
            var str = AttributedString("add_new_card".localized)
            str.underlineStyle = .single
            return str
        }
        
        return VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Payment Methods
                    VStack(alignment: .leading, spacing: 16) {
                        paymentMethodRow(.debitCard)
                        if selectedMethod == .debitCard {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image("ic_radioSelected")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                    Text(selectedCard)
                                        .font(.cairoFont(.semiBold, size: 14))
                                        .foregroundColor(.black)
                                    Spacer()
                                    Button("CVV") {}
                                        .disabled(true)
                                        .frame(width: 60, height: 35)
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.gray)
                                        .cornerRadius(6)
                                }
                                HStack {
                                    Spacer()
                                    

                                    Button(action: {
                                        
                                    }, label: {
                                        Text(addNewCardAttribute)
                                            .font(.cairoFont(.medium, size: 8))
                                            .foregroundColor(Color(hex: "#9C4EF7"))
                                    })
                                        
                                }
                            }
                            .padding(.leading, 30)
                        }
                        
                        paymentMethodRow(.creditCard)
                        paymentMethodRow(.fawry)
                        paymentMethodRow(.instapay)
                    }
                    .padding()
                    
                    // MARK: Total Amount
                    HStack {
                        Text("total_amount".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                        Spacer()
                        Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: totalAmount))")
                            .font(.cairoFont(.semiBold, size: 14))

                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 99).fill(.white))
                    
                    // MARK: Pay Button
                    Button(action: {
                        onPayTap()
                    }) {
                        Text("pay".localized)
                            .font(.cairoFont(.semiBold, size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
                    }
                    
                    Spacer()
                }
                .padding()
    }

    // MARK: Helper
    @ViewBuilder
    private func paymentMethodRow(_ method: PaymentMethod) -> some View {
        HStack {
            Image(selectedMethod == method ? "ic_radioSelected" : "ic_radioUnselected")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)

            Text(method.title)
            Spacer()
        }
        .onTapGesture { selectedMethod = method }
    }
    
    enum PaymentMethod {
        case debitCard, creditCard, fawry, instapay
        
        var title: String {
            switch self {
            case .debitCard: return "debit_card".localized
            case .creditCard: return "credit_card".localized
            case .fawry: return "fawry".localized
            case .instapay: return "instapay".localized
            }
        }
    }
}

#Preview {
    PaymentMethodContentView(onBackTap: {
        
    }, onPayTap: {
        
    })
}
