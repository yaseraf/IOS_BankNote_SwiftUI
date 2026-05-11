//
//  StockDetailsContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import WebKit

final class WebViewStore: ObservableObject {
    let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()
        return WKWebView(frame: .zero, configuration: config)
    }()
}

struct WebView: UIViewRepresentable {
    @ObservedObject var store: WebViewStore
    var chartLoaded:Binding<Bool?>
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        return store.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = url {
            if chartLoaded.wrappedValue == true {return}
            DispatchQueue.main.async {
                chartLoaded.wrappedValue = true
                uiView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1"
                uiView.load(URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad))
            }
            
        }
    }
}

struct StockDetailsContentView: View {
    
    // An enum to represent the different segments in the segmented control.
    enum StockSegment: String, CaseIterable {
        case details = "details"
        case myPosition = "my_positions"
        case orders = "orders"
        case research = "research"
    }
    
    // A state variable to keep track of the currently selected segment.
    @State private var selectedSegment: StockSegment = .details
    @StateObject var webViewStore = WebViewStore()

    var ordersData:Binding<[OrderListUIModel]?>
    var stockData:Binding<GetALLMarketWatchBySymbolUIModel?>
    var chartLoaded:Binding<Bool?>
    var marketNews:Binding<[GetAllMarketNewsBySymbolUIModel]?>
    var ownedShares:Binding<Int?>
    var favoriteWatchlist: Binding<[GetMarketWatchByProfileIDUIModel]>
    var depthByPriceData: Binding<[StatisticsMarketUIModel]?>

    enum selectedChartPeriod: String {
        case dayChart = "1D"
        case weekChart = "1W"
        case monthChart = "1M"
        case yearChart = "1Y"
    }

    @State var selectedChartPeriod:selectedChartPeriod = .dayChart


    var onFavoriteTap: (String) -> Void
    var onBackTap:()->Void
    var onBuyTap:() -> Void
    var onSellTap:() -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Header section.
                VStack(alignment: .leading, spacing: 5) {
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

                        let isFavorite = favoriteWatchlist.wrappedValue.contains(where: { $0.symbol == stockData.wrappedValue?.symbol })

                        Button {
                            onFavoriteTap(stockData.wrappedValue?.symbol ?? "")
                        } label: {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(isFavorite ? Color(hex: "#9C4EF7") : .gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    
                    HStack(alignment: .center) {
                        WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(stockData.wrappedValue?.symbol ?? "").png")) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .padding(.horizontal, 4)
                                    .foregroundStyle(.gray)
                            case .failure:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .padding(.horizontal, 4)
                                    .foregroundStyle(.gray)
                            case .empty:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundStyle(.gray)
                            @unknown default:
                                Image("ic_selectStock")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundStyle(.gray)
                            }
                        }

                        VStack(alignment: .leading, spacing: 0) {
                            Text(stockData.wrappedValue?.symbol ?? "")
                                .font(.cairoFont(.semiBold, size: 18))
                            
                            Text(AppUtility.shared.isRTL ? stockData.wrappedValue?.symbolNameA ?? "" : stockData.wrappedValue?.symbolNameE ?? "")
                                .font(.cairoFont(.semiBold, size: 12))
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .lastTextBaseline, spacing: 6) {
                        Text("egp".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                        
                        Text(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.lastTradePrice ?? "") ?? 0))
                            .font(.cairoFont(.bold, size: 32))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    HStack{
                        Image("ic_topUp")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color(hex: "#1E961E"))
                        
                        Text("\(Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0))% (\("egp".localized) \(Double(stockData.wrappedValue?.netChange ?? "") ?? 0 > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.netChange ?? "") ?? 0)))")
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#1E961E"))
                        
                        Text("today".localized)
                            .font(.cairoFont(.semiBold, size: 12))

                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.bottom, 20)
                
                ScrollView {
                    chartView
                    
                    // Segmented control.
                    HStack(spacing: 0) {
                        ForEach(StockSegment.allCases, id: \.self) { segment in
                            VStack(spacing: 0) {
                                if selectedSegment == segment {
                                    AppUtility.shared.APP_GRADIENT
                                    .frame(maxHeight: 50)
                                    .mask(
                                        HStack(alignment: .center, spacing: 4) {
                                            Circle()
                                                .scaledToFit()
                                                .frame(width: 5, height: 5)
                                                
                                            Text(segment.rawValue.localized)
                                                .font(.cairoFont(.semiBold, size: 12))
                                        }
                                    )
                                } else {
                                    Text(segment.rawValue.localized)
                                        .font(.cairoFont(.semiBold, size: 12))
                                        .foregroundColor(.secondary)
                                }
                                
    //                            if selectedSegment == segment {
    //                                RoundedRectangle(cornerRadius: 1)
    //                                    .frame(height: 2)
    //                                    .foregroundColor(.purple)
    //                            }
                            }
    //                        .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                withAnimation {
                                    self.selectedSegment = segment
                                }
                            }
                        }
                    }
                    .padding(.top)
                    
                    // Dynamic content based on selected segment.
                    ScrollView {
                        VStack(alignment: .leading) {
                            switch selectedSegment {
                            case .details:
                                DetailsView(stockData: stockData, marketNews: marketNews, depthByPriceData: depthByPriceData)
                            case .myPosition:
                                MyPositionView(stockData: stockData, ownedShares: ownedShares)
                            case .orders:
                                OrdersView(ordersData: ordersData)
                            case .research:
                                ResearchView()
                            }
                        }
                    }
                }

                Spacer()
                
                // Buy/Sell buttons.
                HStack(spacing: 20) {
                    Button(action: {
                        onBuyTap()
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("buy".localized)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
//                            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                            
                            RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7"))
                        )
                        .cornerRadius(20)
                    }
                    
                    Button(action: {
                        onSellTap()
                    }) {
                        HStack {
                            Image(systemName: "minus")
                            Text("sell".localized)
                        }
                        .foregroundColor(.purple)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 99)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                    }
                }
                .padding()
            }
        }
    }
    
    private var chartView: some View {
        let chartURL:String = "https://trade.rol.com.eg/tradingView/index.html?symbol=\(UserDefaultController().selectedSymbol ?? "")&theme=\(AppUtility.shared.isDarkTheme ? "NIGHT" : "DAY")&ChartType=candle&period=5D&color=\(Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0 > 0 ? "B" : "R")"
        
        debugPrint("Chart View: \(chartURL)")
        
        return VStack {
            WebView(store: webViewStore, chartLoaded: chartLoaded, url: URL(string: chartURL)!)
        }
        .frame(height: 350)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,  alignment: .center)
        .padding(.horizontal, 18)


    }
}

// MARK: - Details View
struct DetailsView: View {
    
    var stockData:Binding<GetALLMarketWatchBySymbolUIModel?>
    var marketNews:Binding<[GetAllMarketNewsBySymbolUIModel]?>
    var depthByPriceData: Binding<[StatisticsMarketUIModel]?>

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // ── Market Depth ──────────────────────────────────────
            Text("market_depth".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.secondary)
                .padding(.top)
            
            MarketDepthView(rows: depthByPriceData.wrappedValue ?? .init())
            if let depthRows = depthByPriceData.wrappedValue, !depthRows.isEmpty {
            }
            
            Text("\("about".localized) \(AppUtility.shared.isRTL ? stockData.wrappedValue?.symbolNameA ?? "" : stockData.wrappedValue?.symbolNameE ?? "")")
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.secondary)
                .padding(.top)
            
            
            VStack(spacing: 1) {
                Text("Fawry is a leading Egyptian fintech company that provides electronic payment solutions for individuals and businesses. It's services include bill payments, mobile recharge, money transfers, and e-commerce payments.")
                    .font(.cairoFont(.semiBold, size: 12))
                
                Divider()

                InfoRow(label: "CEO", value: "Ashraf Sabry")
                
                Divider()
                
                InfoRow(label: "Ticker Symbol", value: "FWRY")
                
                Divider()
                
                InfoRow(label: "Sector", value: "Financial Services / Fintech")
                
                Divider()
                
                InfoRow(label: "Founded", value: "2008")
                
                Divider()
                
                InfoRow(label: "Headquarters", value: "Cairo, Egypt")
                
                Divider()
                
                InfoRow(label: "Index", value: "EGX30")
            }
            .padding(10)
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            
            Text("statistics".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.secondary)
                .padding(.top)
            
            VStack(spacing: 0) {
                InfoGrid(items: [
                    ("market_cap".localized, "\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.companyMARKETCAP ?? "0") ?? 0))"),
                    ("\("pe".localized) \("ratio".localized)", "\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.pe ?? "0") ?? 0))"),
                    ("volume".localized, "\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.totalVolume ?? "0") ?? 0))"),
                    ("dividend_yield".localized, "\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.companyDIVIDENDYIELDPERC ?? "0") ?? 0))%"),
                    ("52_week_high".localized, "\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.wk52High ?? "0") ?? 0))"),
                    ("52_week_low".localized, "\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.wk52Low ?? "0") ?? 0))"),
                ])
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            
            HStack {
                Text("news".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("view_all".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(RoundedRectangle(cornerRadius: 99).fill(.white))
                }
            }
            .padding(.top)
            
            if marketNews.wrappedValue?.isEmpty == false{
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0...3, id: \.self) { id in
                        newsCellBySymbol(newsData: marketNews.wrappedValue?[id] ?? .initializer())
                            .padding(.horizontal, 26)
                        if id < 3 {
                            Divider()
                        }
                    }
                    .padding(.vertical, 17)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                    .padding(.horizontal, 18)
                }
                .lineSpacing(CGFloat.zero)
            }

            
//            VStack(spacing: 0) {
//                NewsRow(source: "EGX", time: "2 hours ago", title: "ADNOC Distribution Expands to Saudi Arabia", description: "ADNOCDIST announces new fuel stations in KSA as part of its strategic expansion.")
//                
//                Divider()
//                
//                NewsRow(source: "EGX", time: "Yesterday", title: "Emaar Properties Reports 12% Profit Growth in Q1 2025", description: "Strong performance driven by Dubai's real estate market and international operations.")
//                
//                Divider()
//                
//                NewsRow(source: "EGX", time: "3 days ago", title: "Emirates NBD Completes Acquisition of Sberbank...", description: "Emirates NBD has completed the acquisition of Sberbank's full stake in DenizBank...")
//            }
//            .background(Color.white.opacity(0.8))
//            .cornerRadius(10)
        }
        .padding()
    }
}


// MARK: - Market Depth View

struct MarketDepthView: View {
    let rows: [StatisticsMarketUIModel]
    private let displayCount = 5

    private var maxBid: Double {
        rows.prefix(displayCount).compactMap { Double($0.bidQty) }.max() ?? 1
    }
    private var maxAsk: Double {
        rows.prefix(displayCount).compactMap { Double($0.askQty) }.max() ?? 1
    }

    // Totals for footer
    private var totalBidQty: Double {
        rows.prefix(displayCount).compactMap { Double($0.bidQty) }.reduce(0, +)
    }
    private var totalBidPrice: Double {
        rows.prefix(displayCount).compactMap { Double($0.bid) }.reduce(0, +)
    }
    private var totalAskPrice: Double {
        rows.prefix(displayCount).compactMap { Double($0.ask) }.reduce(0, +)
    }
    private var totalAskQty: Double {
        rows.prefix(displayCount).compactMap { Double($0.askQty) }.reduce(0, +)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack(spacing: 0) {
                Text("#")
                    .frame(width: 28, alignment: .leading)
                Text("Bid OTY")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Bid")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Offer")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Offer OTY")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("#")
                    .frame(width: 28, alignment: .trailing)
            }
            .font(.cairoFont(.semiBold, size: 11))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)

            Divider()

            // Rows
            let displayRows = Array(rows.prefix(displayCount).enumerated())
            ForEach(displayRows, id: \.offset) { index, row in
                MarketDepthRow(
                    index: index + 1,
                    row: row,
                    bidPercent: (Double(row.bidQty) ?? 0) / (maxBid == 0 ? 1 : maxBid),
                    askPercent: (Double(row.askQty) ?? 0) / (maxAsk == 0 ? 1 : maxAsk)
                )
                Divider()
            }

            // Footer totals
            HStack(spacing: 0) {
                Text(AppUtility.shared.formatThousandSeparator(number: totalBidQty))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Total")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.cairoFont(.semiBold, size: 13))
                Text(AppUtility.shared.formatThousandSeparator(number: totalAskQty))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .font(.cairoFont(.semiBold, size: 12))
            .foregroundStyle(Color.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .background(Color.white.opacity(0.8))
        .cornerRadius(10)
    }
}

struct MarketDepthRow: View {
    let index: Int
    let row: StatisticsMarketUIModel
    let bidPercent: Double
    let askPercent: Double

    var body: some View {
        HStack(spacing: 0) {
            // Left order count
            Text("\(index)")
                .font(.cairoFont(.semiBold, size: 12))
                .foregroundStyle(.secondary)
                .frame(width: 28, alignment: .leading)

            // Bid Qty with green background bar
            ZStack(alignment: .trailing) {
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color(hex: "#1E961E").opacity(0.12))
                        .frame(width: geo.size.width * CGFloat(bidPercent))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                Text(AppUtility.shared.formatThousandSeparator(number: Double(row.bidQty) ?? 0))
                    .font(.cairoFont(.semiBold, size: 13))
                    .foregroundStyle(Color(hex: "#1E961E"))
                    .padding(.horizontal, 4)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 36)

            // Bid price
            Text(AppUtility.shared.formatThousandSeparator(number: Double(row.bid) ?? 0))
                .font(.cairoFont(.semiBold, size: 13))
                .foregroundStyle(Color(hex: "#1E961E"))
                .frame(maxWidth: .infinity, alignment: .center)

            // Ask price
            Text(AppUtility.shared.formatThousandSeparator(number: Double(row.ask) ?? 0))
                .font(.cairoFont(.semiBold, size: 13))
                .foregroundStyle(Color(hex: "#D32F2F"))
                .frame(maxWidth: .infinity, alignment: .center)

            // Ask Qty with red background bar
            ZStack(alignment: .leading) {
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color(hex: "#D32F2F").opacity(0.12))
                        .frame(width: geo.size.width * CGFloat(askPercent))
                }
                Text(AppUtility.shared.formatThousandSeparator(number: Double(row.askQty) ?? 0))
                    .font(.cairoFont(.semiBold, size: 13))
                    .foregroundStyle(Color(hex: "#D32F2F"))
                    .padding(.horizontal, 4)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 36)

            // Right order count
            Text("\(index)")
                .font(.cairoFont(.semiBold, size: 12))
                .foregroundStyle(.secondary)
                .frame(width: 28, alignment: .trailing)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 2)
    }
}

// MARK: - My Position View
struct MyPositionView: View {
    
    var stockData:Binding<GetALLMarketWatchBySymbolUIModel?>
    var ownedShares:Binding<Int?>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(spacing: 1) {
                InfoGrid(items: [
                    ("you_own".localized, "\(AppUtility.shared.formatThousandSeparator(number: Double(ownedShares.wrappedValue ?? 0) ?? 0)) \("shares".localized)"),
                    ("average_buy_price".localized, "\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.avgPrice ?? "") ?? 0))"),
                    ("total_value".localized, "\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.totalValue ?? "") ?? 0))"),
                    ("dividend_yield".localized, "\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.companyDIVIDENDYIELDPERC ?? "") ?? 0))%")
                ])
                
                Divider()
                
                VStack(alignment: .center, spacing: 0) {
                    Text("profit_loss".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    HStack {
                        Image((Double(stockData.wrappedValue?.netChange ?? "") ?? 0) > 0 ? "ic_stockUp" : (Double(stockData.wrappedValue?.netChange ?? "") ?? 0) < 0 ? "ic_stockDown" : "")
//                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
//                            .foregroundColor(Color(hex: "#1E961E"))
                        
                        Text("\("egp".localized) \((Double(stockData.wrappedValue?.netChange ?? "") ?? 0) > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.netChange ?? "") ?? 0))")
                            .font(.cairoFont(.semiBold, size: 18))
                            .foregroundColor((Double(stockData.wrappedValue?.netChange ?? "") ?? 0) > 0 ? Color.colorPositive : (Double(stockData.wrappedValue?.netChange ?? "") ?? 0) < 0 ? Color.colorNegative : Color.colorWarning600)
                        
                        +
                        
                        Text("(\((Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0) > 0 ? "+" : "")\(AppUtility.shared.formatThousandSeparator(number: Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0))%)")
                            .font(.cairoFont(.semiBold, size: 18))
                            .foregroundColor((Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0) > 0 ? Color.colorPositive : (Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0) < 0 ? Color.colorNegative : Color.colorWarning600)

                    }
                }
                .padding()
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
        }
        .padding()
    }
}

// MARK: - Orders View
struct OrdersView: View {
    var ordersData:Binding<[OrderListUIModel]?>
    
    func formatDate(dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "ddMMyyyyHHmmss"
        inputFormatter.locale = Locale(identifier: "en")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d, yyyy - h:mm a"
        
        guard let date = inputFormatter.date(from: dateString) else {
            return "expected date in format: ddMMyyyyHHmmss, but got: \(dateString)"
        }
        
        return outputFormatter.string(from: date)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("today".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 0) {
                ForEach(ordersData.wrappedValue ?? [], id: \.id) { item in
                    
                    OrderRow(
                        orderItem: item,
                        status: getStatusDescE(m: item),
                        action: item.SellBuyFlag?.lowercased() == "b" ? "buy".localized : "sell".localized,
                        shares: "\(AppUtility.shared.formatThousandSeparator(number: Double(item.Remaining ?? "") ?? 0)) \("shares".localized)",
                        price: "\(AppUtility.shared.formatThousandSeparator(number: Double(item.Price ?? "0") ?? 0))",
                        total: "\(AppUtility.shared.formatThousandSeparator(number: Double(item.LocalValue ?? "0") ?? 0))",
                        date: formatDate(dateString: item.EntryDate ?? ""),
                    )
                    
                    Divider()

                }
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
        }
        .padding()
    }
}

// MARK: - Research View
struct ResearchView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(spacing: 0) {
                NewsRow(source: "EGX", time: "2 hours ago", title: "ADNOC Distribution Expands to Saudi Arabia", description: "ADNOCDIST announces new fuel stations in KSA as part of its strategic expansion.")
                Divider()
                NewsRow(source: "EGX", time: "Yesterday", title: "Emaar Properties Reports 12% Profit Growth in Q1 2025", description: "Strong performance driven by Dubai's real estate market and international operations.")
                Divider()
                NewsRow(source: "EGX", time: "3 days ago", title: "Emirates NBD Completes Acquisition of Sberbank...", description: "Emirates NBD has completed the acquisition of Sberbank's full stake in DenizBank...")
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
        }
        .padding()
    }
}

// MARK: - Reusable Components

struct newsCellBySymbol: View {
    
    var newsData: GetAllMarketNewsBySymbolUIModel
    
    func getHourOfTimeStamp(from dateString: String) -> String {
        // Define the date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        dateFormatter.timeZone = TimeZone.current

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy" // Desired output format

        if let date = dateFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    func getNewsContent(description: String, symbol: String) -> String{
                
        if let rangeStart = description.range(of: "<a"),
           let rangeEnd = description.range(of: "</a>", range: rangeStart.upperBound..<description.endIndex) {
            let content = description[rangeStart.upperBound..<rangeEnd.lowerBound]
            let filter1 = description.replacingOccurrences(of: "<br />", with: "")
            let filter2 = filter1.replacingOccurrences(of: content, with: "")
            let filter3 = filter2.replacingOccurrences(of: "<a</a>", with: "")
            let filter4 = filter3.replacingOccurrences(of: "<br>", with: "")
//            let filter4 = filter3.replacingOccurrences(of: "Company:", with: "")
                return String(filter4)
            }
        return "Symbol Name: \(symbol)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Text("egx".localized)
                    .font(.cairoFont(.light, size: 12))
                    .foregroundStyle(.black)

                Text("•")
                
                Text(getHourOfTimeStamp(from: newsData.newsDate ?? ""))
                    .font(.cairoFont(.light, size: 12))
                    .foregroundStyle(.black)
            }
            
            Text("\(getNewsContent(description: AppUtility.shared.isRTL ? newsData.newsDescA ?? "" : newsData.newsDescE ?? "", symbol: newsData.symbol ?? ""))")
                .font(.cairoFont(.semiBold, size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


// A single row for a label and value.
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.cairoFont(.semiBold, size: 12))
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.cairoFont(.semiBold, size: 12))

        }
        .padding(.vertical, 5)
    }
}

// A grid for displaying two columns of information.
struct InfoGrid: View {
    let items: [(label: String, value: String)]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<items.count / 2) { rowIndex in
                HStack(spacing: 0) {
                    GridItemView(label: items[rowIndex * 2].label, value: items[rowIndex * 2].value)
                    
                    Divider()
                    
                    GridItemView(label: items[rowIndex * 2 + 1].label, value: items[rowIndex * 2 + 1].value)
                }
                
                if rowIndex < items.count / 2 - 1 {
                    Divider()
                }
            }
        }
    }
}

// A single item within the InfoGrid.
struct GridItemView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .font(.cairoFont(.semiBold, size: 12))
                .foregroundColor(.secondary)
            Text(value)
                .font(.cairoFont(.semiBold, size: 18))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// A row for displaying a news article.
struct NewsRow: View {
    let source: String
    let time: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(source)
                    .font(.cairoFont(.light, size: 12))
                Text("•")
                Text(time)
                    .font(.cairoFont(.light, size: 12))
            }
            Text(title)
                .font(.cairoFont(.semiBold, size: 14))

            Text(description)
                .font(.cairoFont(.light, size: 14))
        }
        .padding(.horizontal, 25)
        .padding(.vertical, 17)
    }
}

// A row for displaying an order.
struct OrderRow: View {
    let orderItem: OrderListUIModel
    let status: String
    let action: String
    let shares: String
    let price: String
    let total: String
    let date: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text(status)
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundColor(getForegroundColor(m: orderItem))
                
                HStack(spacing: 5) {
                    Text(action)
                        .font(.cairoFont(.semiBold, size: 18))

                    Text(shares)
                        .font(.cairoFont(.semiBold, size: 18))
                }
                .padding(.bottom, 8)
                
                Text(date)
                    .font(.cairoFont(.light, size: 12))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text(status)
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundColor(getForegroundColor(m: orderItem))
                    .opacity(0)
                
                HStack(spacing: 0) {
                    Text("egp".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    Text(price)
                        .font(.cairoFont(.semiBold, size: 18))
                }

                HStack(spacing: 0) {
                    Text("egp".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    Text(total)
                        .font(.cairoFont(.semiBold, size: 18))
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}



//
//#Preview {
//    StockDetailsContentView(stockData: .constant(.initializer()), chartLoaded: .constant(false), marketNews: .constant([]), ownedShares: .constant(0), onBackTap: {
//        
//    }, onBuyTap: {
//        
//    }, onSellTap: {
//        
//    })
//}
