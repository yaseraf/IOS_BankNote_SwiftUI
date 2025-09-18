//
//  PortfolioContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct PortfolioContentView: View {
    
    var portfolioData:Binding<GetPortfolioUIModel?>
    var pieChartData:Binding<[PieSliceData]?>
        
    var onPortfolioTap:()->Void

    
    var body: some View {
        ZStack {
            VStack {
                
                HeaderView()
                
                PieChartView(data: pieChartData.wrappedValue ?? [], portfolioData: portfolioData)
                    .frame(maxWidth: 250, maxHeight: 250)
                
                portfolioView

                Spacer()
                
            }
            VStack {
                Spacer()
                
                HomeBottomBarView(selectedItem: .portfolio)
            }
        }

    }
        
    private var portfolioView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Array((portfolioData.wrappedValue?.portfolioes ?? []).enumerated()), id: \.offset) { idnex, element in
                Button {
                    onPortfolioTap()
                } label: {
                    PortfolioCell(portfolioData: element)
                }

            }
        }
        .padding(.bottom, 80)

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
}


// MARK: - Model
struct PieSliceData: Identifiable {
    let id = UUID()
    var value: Double
    var color: Color
    var label: String
}

// MARK: - Shape for a single slice
struct PieSlice: Shape {
    // angles in degrees
    var startAngle: Angle
    var endAngle: Angle
    // for animatable transitions
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(startAngle.degrees, endAngle.degrees) }
        set {
            startAngle = .degrees(newValue.first)
            endAngle = .degrees(newValue.second)
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) * 0.5
        path.move(to: center)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle - Angle(degrees: 90),
                    endAngle: endAngle - Angle(degrees: 90),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}

// MARK: - Pie Chart View
struct PieChartView: View {
    var data: [PieSliceData]
    var portfolioData:Binding<GetPortfolioUIModel?>
    var showPercentages: Bool = true
    var innerRadiusFraction: CGFloat = 0 // 0 = full pie, >0 = donut (0.6 typical)
    @State private var selectedSlice: UUID? = nil
    @State private var animate: Bool = false

    private var total: Double {
        data.reduce(0) { $0 + $1.value }
    }

    // convert values to cumulative angles (0..360)
    private func angles() -> [(data: PieSliceData, start: Double, end: Double)] {
        var angles: [(PieSliceData, Double, Double)] = []
        var startAngle: Double = 0
        for d in data {
            let portion = (total > 0) ? (d.value / total) : 0
            let degrees = portion * 360
            let end = startAngle + degrees
            angles.append((d, startAngle, end))
            startAngle = end
        }
        return angles
    }

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            ZStack {
                ForEach(angles(), id: \.data.id) { item in
                    let isSelected = selectedSlice == item.data.id
                    PieSlice(startAngle: .degrees(animate ? item.start : item.start),
                             endAngle: .degrees(animate ? item.end : item.start)) // animate end to full
                        .fill(item.data.color)
                        .overlay(
                            PieSlice(startAngle: .degrees(item.start), endAngle: .degrees(item.end))
                                .stroke(Color(hex: "#1C1C1C"), lineWidth: 1)
                                .opacity(0.9)
                        )
                        // make selected slice pop out
                        .offset(x: isSelected ? 8 * cos(((item.start + item.end) / 2 - 90) * .pi / 180) : 0,
                                y: isSelected ? 8 * sin(((item.start + item.end) / 2 - 90) * .pi / 180) : 0)
                        .scaleEffect(isSelected ? 1.02 : 1.0)
                        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: selectedSlice)
                        .onTapGesture {
                            if selectedSlice == item.data.id { selectedSlice = nil }
                            else { selectedSlice = item.data.id }
                        }
                }

                // Donut hole (if requested)
                if innerRadiusFraction > 0 {
                    Circle()
                        .fill(Color(.systemBackground))
                        .frame(width: size * innerRadiusFraction, height: size * innerRadiusFraction)
                        .shadow(radius: 0)
                }

                // Center label (show total or selected slice)
                VStack {
                    if let selected = data.first(where: { $0.id == selectedSlice }) {
                        Text(selected.label)
                            .font(.cairoFont(.semiBold, size: 14))
                            .multilineTextAlignment(.center)
                        if showPercentages {
                            let pct = total > 0 ? selected.value / total * 100 : 0
                            Text(String(format: "%.1f%%", pct))
                                .font(.cairoFont(.semiBold, size: 14))
                                .foregroundColor(.secondary)
                        } else {
                            Text("\(Int(selected.value))")
                                .font(.cairoFont(.semiBold, size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
//                    else {
//                        Text("Total")
//                            .font(.headline)
//                        Text("\(total, specifier: total == floor(total) ? "%.0f" : "%.1f")")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
                }
            }
            // draw labels around the pie (percent labels)
            .overlay(
                ZStack {
                    ForEach(angles(), id: \.data.id) { item in
                        if showPercentages {
                            let mid = (item.start + item.end) / 2
                            let radius = size * 0.42
                            let angleRad = (mid - 90) * .pi / 180
                            let x = center.x + cos(angleRad) * radius
                            let y = center.y + sin(angleRad) * radius
                            let pct = total > 0 ? item.data.value / total * 100 : 0
                            Text(String(format: "%.0f%%", pct))
                                .font(.cairoFont(.semiBold, size: 14))
                                .bold()
                                .position(x: x, y: y)
                                .shadow(radius: 0.5)
                                .allowsHitTesting(false)
                        }
                    }
                }
            )

            // legend at bottom
            .overlay(
                VStack(spacing: 8) {
//                    Spacer()
//                    HStack(spacing: 12) {
//                        ForEach(data) { d in
//                            HStack(spacing: 6) {
//                                Rectangle()
//                                    .frame(width: 14, height: 14)
//                                    .cornerRadius(3)
//                                    .foregroundColor(d.color)
//                                Text(d.label)
//                                    .font(.caption)
//                            }
//                            .padding(.horizontal, 4)
//                        }
//                    }
//                    .padding(.bottom, 8)
                    
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
                    }
                    .offset(y: -40)

                    Spacer()

                }
            )
            .frame(width: geo.size.width, height: geo.size.height)
            .onAppear {
                // animate drawing
                withAnimation(.easeOut(duration: 0.8)) {
                    animate = true
                }
            }

        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
}

#Preview {
    PortfolioContentView(portfolioData: .constant(GetPortfolioUIModel.testUIModel()), pieChartData: .constant([]), onPortfolioTap: {
        
    })
}
