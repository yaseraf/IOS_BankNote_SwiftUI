//
//  QuestioneerContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import SwiftUI

import WebKit

struct IFrameWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}


struct QuestioneerContentView: View {
    
    @State var stepNumber: Int = 6
    @Binding var fieldValues: [String: String]

    @Binding var kycFieldsData: GetKycFieldValifyUIModel?
    @Binding var showContract: Bool
    @Binding var contractURL: String
    
    @Binding var selectContractsItemPicker: [ItemPickerModelType]
    
    @State private var riskAnswer = false

    
    var onConfirmTap:()->Void
    var onContractsTap:()->Void
    var onEndContractSigning:()->Void
    
    var body: some View {
        VStack {
            logoView
            
            SegmentsView(stepNumber: stepNumber)
            
            VStack(spacing: 17) {
                
                ScrollView(showsIndicators: false) {
                    contentView
                    valifyFieldsView
                }
                
                fieldsView
                
                
                bottomView
            }
            
            Spacer()
        }
        .sheet(isPresented: $showContract, onDismiss: {
            showContract = false
            if selectContractsItemPicker.isEmpty == false {
                selectContractsItemPicker.removeFirst()
            } else {
                onEndContractSigning()
            }
        }) {
            if let url = URL(string: contractURL) {
                IFrameWebView(url: url)
            }
        }
    }
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 90, maxHeight: 90)
            
            Text("XNTRQ".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 16))
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("do_any_of_these_apply_to_you".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("investment_risks".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                            Text("investing_in_nature_funds_and_bonds_involves_risks".localized)
                                .font(.cairoFont(.light, size: 12))
                        }
                        Text("the_value_of_your_investment_can_go_up_or_down._you_might_not_get_back_the_amount_you_originally_invested.".localized)
                            .font(.cairoFont(.light, size: 12))
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("no_guarantee".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                            Text("there_is_no_guarantee_of_returns_past_performance".localized)
                                .font(.cairoFont(.light, size: 12))
                        }
                        Text("is_not_indicative_of_the_future_results".localized)
                            .font(.cairoFont(.light, size: 12))
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("fees_and_charges".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                            Text("there_may_be_fees_and_charges_associated_with".localized)
                                .font(.cairoFont(.light, size: 12))
                        }
                        Text("your_investment_please_review_the_fee_schedule_for_details".localized)
                            .font(.cairoFont(.light, size: 12))
                    }
                }
            }
            .lineLimit(0)
            
            VStack(spacing: 4) {
                HStack {
                    Text("yes".localized)
                        .font(.cairoFont(.regular, size: 12))
                    Spacer()
                    Image("ic_radioFill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                .onTapGesture {
                    riskAnswer = true
                }
                
                HStack {
                    Text("no".localized)
                        .font(.cairoFont(.regular, size: 12))
                    Spacer()
                    Image("ic_radioEmpty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                .onTapGesture {
                    riskAnswer = false
                }

            }
        }
        .padding(.horizontal, 18)
    }
    
    func binding(for fieldId: String) -> Binding<String> {
        Binding(
            get: {
                fieldValues[fieldId] ?? ""
            },
            set: {
                fieldValues[fieldId] = $0
            }
        )
    }

    private var valifyFieldsView: some View {
        VStack {
            ForEach(kycFieldsData?.data ?? [], id: \.id) { item in
                if item.isMandatory?.lowercased() == "y", let fieldId = item.fieldId {
                    VStack(alignment: .leading, spacing: 4) {
                        
                        Text(item.label ?? "")
                            .font(.cairoFont(.light, size: 12))

                        TextField("\(item.label ?? "")",text: binding(for: fieldId))
                        .font(.cairoFont(.semiBold, size: 12))
                        .keyboardType(item.type?.lowercased() == "text" ? .default : .numberPad)
                        .foregroundStyle(Color(hex: "#1C1C1C"))
                        .padding(.horizontal, 16)
                        .frame(height: 56)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))

                    }
                    .padding(.horizontal, 16)
                    

                }
            }
        }
    }
    
    private var fieldsView: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Button(action: {

                }, label: {
                    HStack {
                        VStack(spacing: 0) {
                            Text("source_of_fund".localized)
                                .font(.cairoFont(.light, size: 12))
                            Text("salary".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                        }

                        Spacer()
                        
                        Image("ic_downArrow")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                            .frame(width: 15, height: 15)
                    }
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                })
            }
            .padding(.horizontal, 18)
            HStack(spacing: 8) {
                Button(action: {

                }, label: {
                    HStack {
                        VStack(spacing: 0) {
                            Text("investment_objectives".localized)
                                .font(.cairoFont(.light, size: 12))
                            Text("fixed_income".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                        }

                        Spacer()
                        
                        Image("ic_downArrow")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                            .frame(width: 15, height: 15)
                    }
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                })
            }
            .padding(.horizontal, 18)

            HStack(spacing: 8) {
                Button(action: {
                    onContractsTap()
                }, label: {
                    HStack {
                        VStack(spacing: 0) {
                            Text("investment_product".localized)
                                .font(.cairoFont(.light, size: 12))
                            Text(selectContractsItemPicker.map { $0.name }.joined(separator: ", "))
                                .font(.cairoFont(.semiBold, size: 12))
                        }

                        Spacer()
                        
                        Image("ic_downArrow")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                            .frame(width: 15, height: 15)
                    }
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                })
            }
            .padding(.horizontal, 18)

        }
    }

    private var bottomView: some View {
        return VStack {
            Button {
                onConfirmTap()
            } label: {
                Text("confirm".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
            
            Spacer().frame(height: 24)
        }
    }

}

//#Preview {
//    QuestioneerContentView(onConfirmTap: {
//        
//    })
//}
