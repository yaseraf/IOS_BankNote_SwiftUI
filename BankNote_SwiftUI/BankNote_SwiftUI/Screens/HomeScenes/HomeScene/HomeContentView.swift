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
    var customWatchListData: Binding<[GetMarketWatchByProfileIDUIModel]?>
    var portfolioData:Binding<GetPortfolioUIModel?>
    @State var isBalanceHidden:Bool = false
    @State private var selectedOption: HomeTotalAssetsType = .totalInvestmentValue
    @State private var selectedTab: HomePortfolioTab = .portfolio
    @State private var customWatchlistCellExpanded = false
    
    var onTopUpTap:()->Void
    var onStockTap:(String, String, String, String) -> Void
    var onWithdrawalTap:()->Void
    var onViewHistoryTap:()->Void
    var onPortfolioViewAllTap:()->Void
    var onMyWatchlistViewAllTap:([GetMarketWatchByProfileIDUIModel])->Void
    
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
            Button("total_investment_value".localized, action: { selectedOption = .totalInvestmentValue })
            Button("total_available_balance".localized, action: { selectedOption = .totalAvailableBalance })

            }, label: {
                Label(selectedOption.name, systemImage: "chevron.down")
                    .foregroundStyle(.black)
                    .padding()
//                    .background(Color.blue.opacity(0.1))
                    .background(Color(hex: "#DDDDDD"))
                    .cornerRadius(99)

            }
        )
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
                Text(isBalanceHidden ? "*******" : "\(accountCurrency) \(selectedOption == .totalInvestmentValue ? AppUtility.shared.formatThousandSeparator(number: totalAsset) : String(balance ?? 0))")
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
                    .foregroundStyle(accountPnL > 0 ? Color.colorPositive : accountPnL < 0 ? Color.colorNegative : Color.colorWarning600)

                ZStack {
                    Text("\(AppUtility.shared.formatThousandSeparator(number: Double(accountPnLPerc)))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(accountPnLPerc > 0 ? Color.colorPositive : accountPnLPerc < 0 ? Color.colorNegative : Color.colorWarning600)
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 7)
                .background(RoundedRectangle(cornerRadius: 99).fill(accountPnLPerc > 0 ? Color(hex: "#D4EBCF") : accountPnLPerc < 0 ? Color(hex: "#EBCFCF") : Color.colorWarning50))
                .background(RoundedRectangle(cornerRadius: 99).fill(accountPnLPerc > 0 ? Color(hex: "#D4EBCF") : accountPnLPerc < 0 ? Color(hex: "#EBCFCF") : Color.colorWarning200))
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
                        
                        Text("withdraw".localized)
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
                // My Portfolio Tab
                Button {
                    selectedTab = .portfolio
                } label: {
                    HStack(spacing: 4) {
                        Text("my_portfolio".localized)
                            .font(.cairoFont(.semiBold, size: selectedTab == .portfolio ? 18 : 14))
                            .foregroundStyle(selectedTab == .portfolio ? .black : Color(hex: "#9C9C9C"))

                        ZStack {
                            Text("\(portfolioData.wrappedValue?.portfolioes.count ?? 0)")
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                        }
                        .padding(.horizontal, 4)
//                        .background(RoundedRectangle(cornerRadius: 2).fill(selectedTab == .portfolio ? .white : Color(hex: "#EEEEEE")))
                        .background(RoundedRectangle(cornerRadius: 2).fill(.white))
                    }
                }
                .opacity(selectedTab == .portfolio ? 1 : 0.5)

                // Divider
                Text("|")
                    .foregroundStyle(Color(hex: "#CCCCCC"))
                    .padding(.horizontal, 4)

                // My Watchlist Tab
                Button {
                    selectedTab = .watchlist
                } label: {
                    HStack(spacing: 4) {
                        Text("my_watchlist".localized)
                            .font(.cairoFont(.semiBold, size: selectedTab == .watchlist ? 18 : 14))
                            .foregroundStyle(selectedTab == .watchlist ? .black : Color(hex: "#9C9C9C"))

                        ZStack {
                            Text("\(customWatchListData.wrappedValue?.count ?? 0)")
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                        }
                        .padding(.horizontal, 4)
//                        .background(RoundedRectangle(cornerRadius: 2).fill(selectedTab == .watchlist ? .white : Color(hex: "#EEEEEE")))
                        .background(RoundedRectangle(cornerRadius: 2).fill(.white))
                    }
                }
                .opacity(selectedTab == .watchlist ? 1 : 0.5)

                Spacer()

                ZStack {
                    Button {
                        if selectedTab == .portfolio {
                            onPortfolioViewAllTap()
                        } else {
                            onMyWatchlistViewAllTap(customWatchListData.wrappedValue ?? [])
                        }
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

            if selectedTab == .portfolio {
                if portfolioData.wrappedValue?.portfolioes.isEmpty == false {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(portfolioData.wrappedValue?.portfolioes ?? [], id: \.id) { item in
                            Button {
                                onStockTap(item.symbol ?? "", item.marketType ?? "", item.custodianID ?? "", AppUtility.shared.isRTL ? item.custodianA ?? "" : item.custodianE ?? "")
                            } label: {
                                PortfolioCell(portfolioData: item)
                            }
                        }
                    }
                    .padding(.bottom, 80)
                }
            } else {
                if customWatchListData.wrappedValue?.isEmpty == false {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(customWatchListData.wrappedValue ?? [], id: \.id) { item in
                            Button {
                                onStockTap(item.symbol ?? "", item.marketType ?? "", "", "")
                            } label: {
                                CustomWatchlistCell(watchlistData: item, customWatchlistCellExpanded: $customWatchlistCellExpanded)
                            }
                        }
                    }
                    .padding(.bottom, 80)
                } else {
                    Spacer()
                    Text("no_watchlist_available".localized)
                        .foregroundStyle(Color(hex: AppUtility.shared.APP_MAIN_COLOR))
                        .font(.cairoFont(.extraBold, size: 14))
                }
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
                    Image(portfolioData.pPerc ?? 0 > 0 ? "ic_stockUp" : portfolioData.pPerc ?? 0 < 0 ? "ic_stockDown" : "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(portfolioData.pPerc ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: portfolioData.pPerc ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(portfolioData.pPerc ?? 0 > 0 ? Color(hex: "#1E961E") : portfolioData.pPerc ?? 0 < 0 ? Color(hex: "#AA1A1A") : Color.colorWarning600 )
                }
                
                
                
                Text("\("egp".localized) \(portfolioData.pProf ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: portfolioData.pProf ?? 0))")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(portfolioData.pProf ?? 0 > 0 ? Color(hex: "#1E961E") : portfolioData.pProf ?? 0 < 0 ? Color(hex: "#AA1A1A") : Color.colorWarning600 )

            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}

struct CustomWatchlistCell: View {

    var watchlistData: GetMarketWatchByProfileIDUIModel
    @Binding var customWatchlistCellExpanded: Bool

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                HStack(spacing: 16) {
                    WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(watchlistData.symbol ?? "").png")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 45, maxHeight: 45)
                                .padding(.horizontal, 4)
                        case .failure, .empty:
                            Image("ic_selectStock")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 45, maxHeight: 45)
                                .padding(.horizontal, 4)
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
                        Text(watchlistData.symbol ?? "")
                            .font(.cairoFont(.semiBold, size: 14))
                        Text(AppUtility.shared.isRTL ? watchlistData.symbolNameA ?? "" : watchlistData.symbolNameE ?? "")
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#9C9C9C"))
                    }
                    .foregroundStyle(.black)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 0) {
                    let change = Double(watchlistData.netChange ?? "") ?? 0
                    let changePerc = Double(watchlistData.netChangePerc ?? "") ?? 0
                    
                    Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: change))")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(.black)
                    
                    HStack(spacing: 4) {
                        Image(changePerc > 0 ? "ic_stockUp" : changePerc < 0 ? "ic_stockDown" : "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)

                        Text("\(changePerc > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(changePerc)))%")
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(changePerc > 0 ? Color(hex: "#1E961E") : changePerc < 0 ? Color(hex: "#AA1A1A") : Color.colorWarning600)
                    }

                }
                
                Image("ic_downArrow")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(hex: "#9C4EF7"))
                    .frame(width: 14, height: 14)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        withAnimation {
                            customWatchlistCellExpanded.toggle()
                        }
                    }
                
                
            }
            
            if customWatchlistCellExpanded {
                HStack {
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            Text("bid".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(watchlistData.bidPrice ?? "") ?? 0))")
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("bid_volume".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(watchlistData.bidVolume ?? "") ?? 0))")
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {

                        VStack(alignment: .leading) {
                            Text("ask".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(watchlistData.offerPrice ?? "") ?? 0))")
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("ask_volume".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                            Text("\(AppUtility.shared.formatThousandSeparator(number: Double(watchlistData.offerVolume ?? "") ?? 0))")
                                .font(.cairoFont(.semiBold, size: 12))
                                .foregroundStyle(.black)
                        }
                    }
                }
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
