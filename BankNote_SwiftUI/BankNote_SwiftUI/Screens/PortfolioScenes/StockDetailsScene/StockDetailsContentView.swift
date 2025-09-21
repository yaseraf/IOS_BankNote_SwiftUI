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
        case details = "Details"
        case myPosition = "My Position"
        case orders = "Orders"
        case research = "Research"
    }
    
    // A state variable to keep track of the currently selected segment.
    @State private var selectedSegment: StockSegment = .details
    @StateObject var webViewStore = WebViewStore()

    var stockData:Binding<GetALLMarketWatchBySymbolUIModel?>
    var chartLoaded:Binding<Bool?>

    enum selectedChartPeriod: String {
        case dayChart = "1D"
        case weekChart = "1W"
        case monthChart = "1M"
        case yearChart = "1Y"
    }

    @State var selectedChartPeriod:selectedChartPeriod = .dayChart


    
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
                        
                        Image(systemName: "bookmark")
                            .font(.title2)
                        Image(systemName: "bell")
                            .font(.title2)
                            .padding(.leading, 10)
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
                    .padding(.top)

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
                        
                        Text("Today")
                            .font(.cairoFont(.semiBold, size: 12))

                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.bottom, 20)
                
                chartView
                
                // Segmented control.
                HStack(spacing: 0) {
                    ForEach(StockSegment.allCases, id: \.self) { segment in
                        VStack(spacing: 0) {
                            if selectedSegment == segment {
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .frame(maxHeight: 50)
                                .mask(
                                    Text(segment.rawValue)
                                        .font(.cairoFont(.semiBold, size: 12))
                                )
                            } else {
                                Text(segment.rawValue)
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
                            DetailsView()
                        case .myPosition:
                            MyPositionView()
                        case .orders:
                            OrdersView()
                        case .research:
                            ResearchView()
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
                            Text("Buy")
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
                            Text("Sell")
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
        let chartURL:String = "https://mahfaztyplus.cicapital.com/MobileServices/tradingView/mobile_Green.html?symbol=\(UserDefaultController().selectedSymbol ?? "")&theme=\(AppUtility.shared.isDarkTheme ? "NIGHT" : "DAY")&ChartType=mountain&period=1D&color=\(Double(stockData.wrappedValue?.netChangePerc ?? "") ?? 0 > 0 ? "B" : "R")"

        return VStack {
            WebView(store: webViewStore, chartLoaded: chartLoaded, url: URL(string: chartURL)!)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 200,  alignment: .center)
        .padding(.horizontal, 18)


    }
}

// MARK: - Details View
struct DetailsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("About Fawry")
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
            
            Text("Statistics")
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.secondary)
                .padding(.top)
            
            VStack(spacing: 0) {
                InfoGrid(items: [
                    ("Market cap", "EGP 521.456B"),
                    ("P/E Ratio", "13.5"),
                    ("Volume", "2.1M"),
                    ("Dividend Yield", "4.2%"),
                    ("52-Week High", "EGP 600"),
                    ("52-Week Low", "EGP 430")
                ])
            }
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            
            HStack {
                Text("News")
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

// MARK: - My Position View
struct MyPositionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(spacing: 1) {
                InfoGrid(items: [
                    ("You Own", "10 Shares"),
                    ("Average Buy Price", "EGP 13.75"),
                    ("Total Value", "EGP 2,178"),
                    ("Dividend Yield", "4.8%")
                ])
                
                Divider()
                
                VStack(alignment: .center, spacing: 0) {
                    Text("Profit/Loss")
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    HStack {
                        Image("ic_topUp")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(hex: "#1E961E"))
                        Text("EGP +115.5 (+5.6%)")
                            .font(.cairoFont(.semiBold, size: 18))
                            .foregroundColor(Color(hex: "#1E961E"))

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
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("today".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.secondary)
            
            VStack(spacing: 0) {
                OrderRow(status: "Completed", action: "Buy", shares: "100 Shares", price: "22.3", total: "2,230", date: "Apr 30, 2025 - 11:20 AM", isCompleted: true)
                
                Divider()
                
                OrderRow(status: "Completed", action: "Buy", shares: "8 Shares", price: "22.3", total: "178.4", date: "Apr 30, 2025 - 10:20 AM", isCompleted: true)
                
                Divider()
                
                OrderRow(status: "Canceled", action: "Buy", shares: "10 Shares", price: "22.1", total: "221.0", date: "Apr 30, 2025 - 10:20 AM", isCompleted: false)
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
    let status: String
    let action: String
    let shares: String
    let price: String
    let total: String
    let date: String
    let isCompleted: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text(status)
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundColor(isCompleted ? Color(hex: "#1E961E") : Color(hex: "#AA1A1A"))
                
                HStack(spacing: 5) {
                    Text(action)
                        .font(.cairoFont(.semiBold, size: 18))

                    Text(shares)
                        .font(.cairoFont(.semiBold, size: 18))
                }
                
                Text(date)
                    .font(.cairoFont(.light, size: 12))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text(status)
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundColor(isCompleted ? Color(hex: "#1E961E") : Color(hex: "#AA1A1A"))
                    .opacity(0)
                
                HStack(spacing: 0) {
                    Text("EGP")
                        .font(.cairoFont(.semiBold, size: 12))
                    Text(price)
                        .font(.cairoFont(.semiBold, size: 18))
                }

                HStack(spacing: 0) {
                    Text("EGP")
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

#Preview {
    StockDetailsContentView(stockData: .constant(.initializer()), chartLoaded: .constant(false), onBackTap: {
        
    }, onBuyTap: {
        
    }, onSellTap: {
        
    })
}
