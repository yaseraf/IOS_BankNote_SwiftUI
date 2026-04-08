//
//  HomeContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import PaymobSDK

struct ViewControllerResolver: UIViewControllerRepresentable {
    
    var onResolve: (UIViewController) -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        ResolverViewController(onResolve: onResolve)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

class ResolverViewController: UIViewController {
    
    var onResolve: (UIViewController) -> Void
    
    init(onResolve: @escaping (UIViewController) -> Void) {
        self.onResolve = onResolve
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onResolve(self)
    }
}
struct HomeContentView: View {
    
    @StateObject private var paymobViewController = PaymobViewController()
    @Binding var viewController: UIViewController?

    var portfolioData:Binding<GetPortfolioUIModel?>
    @State var isBalanceHidden:Bool = false
    @State private var selectedOption: String = "Select an Option"
    
    var onTopUpTap:()->Void
    var onStockTap:(String, String, String, String) -> Void
    var onWithdrawalTap:()->Void
    var onViewHistoryTap:()->Void
    var onPortfolioViewAllTap:()->Void
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                totalInvestmentView
                
                balanceView
                
                if portfolioData.wrappedValue?.portfolioes.isEmpty == true {
                    Spacer()
                    Text("no_portfolios_available".localized)
                        .foregroundStyle(Color(hex: AppUtility.shared.APP_MAIN_COLOR))
                        .font(.cairoFont(.extraBold, size: 14))

                } else {
                    portfolioView
                }

                
                Spacer()
                
            }
            VStack {
                Spacer()
                
                HomeBottomBarView(selectedItem: .home)
            }
            
            ViewControllerResolver { vc in
                self.viewController = vc
            }
            .frame(width: 0, height: 0)

        }
//        .onChange(of: paymobAuthKey) { newValue in
//            if let newValue {
//                presentPaymob(secret: newValue)
//            }
//        }

    }
    
//    func presentPaymob(secret: String) {
//
//        guard let rootVC = UIApplication.shared
//            .connectedScenes
//            .compactMap({ $0 as? UIWindowScene })
//            .first?
//            .windows
//            .first?
//            .rootViewController else { return }
//
//        let paymob = PaymobSDK()
//        
//        paymob.paymobSDKCustomization.appIcon = UIImage()
//        paymob.paymobSDKCustomization.appName = "tester"
//        paymob.paymobSDKCustomization.buttonBackgroundColor = UIColor.black
//        paymob.paymobSDKCustomization.buttonTextColor = UIColor.white
//        paymob.paymobSDKCustomization.showSaveCard = true
//        paymob.paymobSDKCustomization.saveCardDefault = false
//
//        paymob.delegate = PaymobViewController.shared
//
//        try? paymob.presentPayVC(
//            VC: rootVC,
//            PublicKey: "1234",
//            ClientSecret: "1234"
//        )
//    }
    
        
    private var totalInvestmentView: some View {
        Menu(content: {
            Button("Option 1", action: { selectedOption = "Option 1" })
            Button("Option 2", action: { selectedOption = "Option 2" })

        }, label: {
            Label(selectedOption, systemImage: "chevron.down")
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)

        })
//        HStack {
//            Text("total_investment_value".localized)
//                .font(.cairoFont(.semiBold, size: 14))
//            
//            Image("ic_downArrow")
//                .renderingMode(.template)
//                .resizable()
//                .scaledToFit()
//                .foregroundStyle(Color(hex: "#9C4EF7"))
//                .frame(width: 10, height: 10)
//        }
//        .padding(.vertical, 5)
//        .padding(.horizontal, 10)
//        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
    }
    
    private var balanceView: some View {
        
        var viewHistoryAttribute: AttributedString {
            var str = AttributedString("view_history".localized)
            str.underlineStyle = .single
            return str
        }
        
        let accountCurrency = UserDefaultController().selectedUserAccount?.CUR_CODE ?? ""
        let marketValue = Double(portfolioData.wrappedValue?.accountSummaries.marketValue ?? "0")
        let balance = Double(portfolioData.wrappedValue?.accountSummaries.balance ?? "0")
        
        let totalAsset: Double = (marketValue ?? 0) + (balance ?? 0)
        
//        let accountPnL = portfolioData.wrappedValue?.accountSummaries.expectedProfitLoss ?? ""

        let accountPnL = portfolioData.wrappedValue?.portfolioes.first?.totalExpectedProfitLoss ?? 0
        let accountPnLPerc = portfolioData.wrappedValue?.portfolioes.first?.totalEPLossPerc ?? 0

        
        return VStack(spacing: 8) {
            HStack {
                Text(isBalanceHidden ? "*******" : "\(accountCurrency) \(AppUtility.shared.formatThousandSeparator(number: totalAsset))")
                    .font(.cairoFont(.bold, size: 32))
                
                Image(isBalanceHidden ? "ic_eyeVisible" : "ic_eyeInvisible")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        withAnimation {
                            isBalanceHidden.toggle()
                        }
                    }
            }
            
            HStack {
                Text("\(accountCurrency) \(AppUtility.shared.formatThousandSeparator(number: Double(accountPnL)))")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(accountPnL > 0 ? Color.colorPositive : Color.colorNegative)
                
                ZStack {
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(accountPnLPerc)))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(accountPnL > 0 ? Color.colorPositive : Color.colorNegative)
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 7)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: accountPnL > 0 ? "#D4EBCF" : "#EBCFCF")))
            }
            
            HStack(spacing: 21) {
                Button {
                    onTopUpTap()
//                    paymobViewController.presentPaymob(vc: viewController)
                } label: {
                    VStack(spacing: 4) {
                        Image("ic_topUp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("top_up".localized)
                            .font(.cairoFont(.semiBold, size: 10))
                            .foregroundStyle(Color(hex: "#629AF9"))
                    }
                    .padding(.horizontal, 23)
                    .padding(.vertical, 2)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                }

                Button {
                    onWithdrawalTap()
                } label: {
                    VStack(spacing: 4) {
                        Image("ic_withdrawal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("withdrawal".localized)
                            .font(.cairoFont(.semiBold, size: 10))
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 2)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                }
            }
            
            Button {
                onViewHistoryTap()
            } label: {
                Text(viewHistoryAttribute)
                    .font(.cairoFont(.semiBold, size: 10))
                    .foregroundStyle(Color(hex: "#629AF9"))
            }

            
        }
    }
    
    private var portfolioView: some View {
        VStack {
            HStack {
                Text("my_portfolio".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.black)
                
                ZStack {
                    Text("\(portfolioData.wrappedValue?.portfolioes.count ?? 0)")
                        .font(.cairoFont(.semiBold, size: 12))
                }
                .padding(.horizontal, 4)
                .background(RoundedRectangle(cornerRadius: 2).fill(.white))
                
                Spacer()
                
                ZStack {
                    Button {
                        onPortfolioViewAllTap()
                    } label: {
                        Text("view_all".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                            .foregroundStyle(.black)
                    }

                }
                .padding(.vertical, 3)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 99).fill(.white))
            }
            .padding(.horizontal, 18)
            
            
            if portfolioData.wrappedValue?.portfolioes.isEmpty == false{
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(portfolioData.wrappedValue?.portfolioes ?? [], id:\.id) { item in
                        Button {
                            onStockTap(item.symbol ?? "", item.marketType ?? "", item.custodianID ?? "", AppUtility.shared.isRTL ? item.custodianA ?? "" : item.custodianE ?? "")
                        } label: {
                            PortfolioCell(portfolioData: item)
                        }

                    }
                }
                .padding(.bottom, 80)
            }
        }
    }
    
}

struct PortfolioCell: View {
    
    var portfolioData: Portfolio
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(portfolioData.symbol ?? "").png")) { phase in
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
                    Text("\(portfolioData.symbol ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: portfolioData.prClosePrice ?? 0))")
                        .font(.cairoFont(.semiBold, size: 12))
                }
                .foregroundStyle(.black)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 4) {
                    Image(portfolioData.pPerc ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(portfolioData.pPerc ?? 0 >= 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: portfolioData.pPerc ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: portfolioData.pPerc ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
                }
                
                
                
                Text("\("egp".localized) \(portfolioData.pProf ?? 0 >= 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: portfolioData.pProf ?? 0))")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: portfolioData.pPerc ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))

            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}



//#Preview {
//    HomeContentView(paymobAuthKey: .constant(""), portfolioData: .constant(.initializer()), onTopUpTap: {
//        
//    }, onStockTap: { _,_,_,_ in
//        
//    }, onWithdrawalTap: {
//        
//    })
//}
