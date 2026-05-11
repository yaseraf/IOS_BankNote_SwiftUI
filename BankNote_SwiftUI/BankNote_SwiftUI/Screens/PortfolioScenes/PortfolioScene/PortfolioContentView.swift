//
//  PortfolioContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import Darwin

struct PortfolioContentView: View {
    
    var portfolioData:Binding<GetPortfolioUIModel?>
    var pieChartData:Binding<[PieSliceData]?>
        
    var onPortfolioTap:((String,String,String,String)->Void)

    
    var body: some View {
        ZStack {
            VStack {
                
                HeaderView()
                
                if pieChartData.wrappedValue?.isEmpty == true {
                    Spacer()
                    Text("no_chart_data_available".localized)
                        .foregroundStyle(Color(hex: AppUtility.shared.APP_MAIN_COLOR))
                        .font(.cairoFont(.extraBold, size: 14))
                } else {
//                    PieChartView(data: pieChartData.wrappedValue ?? [], portfolioData: portfolioData)
//                        .frame(maxWidth: 250, maxHeight: 250)
                    
                    PieChart3DView(data: pieChartData.wrappedValue ?? [], portfolioData: portfolioData)
                        .frame(maxWidth: 300, maxHeight: 260)
                }
                
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
                
                HomeBottomBarView(selectedItem: .portfolio)
            }
        }

    }
        
    @ViewBuilder
    private var portfolioView: some View {
        if portfolioData.wrappedValue?.portfolioes.isEmpty == false {
//            ScrollView(.vertical, showsIndicators: false) {
//                ForEach(Array((portfolioData.wrappedValue?.portfolioes ?? []).enumerated()), id: \.offset) { idnex, element in
//                    Button {
//                        onPortfolioTap()
//                    } label: {
//                        PortfolioCell(portfolioData: element)
//                    }
//
//                }
//            }
//            .padding(.bottom, 80)
            
           ScrollView(.vertical, showsIndicators: false) {
               ForEach(portfolioData.wrappedValue?.portfolioes ?? [], id:\.id) { item in
                   Button {
                       onPortfolioTap(item.symbol ?? "", item.marketType ?? "", item.custodianID ?? "", AppUtility.shared.isRTL ? item.custodianA ?? "" : item.custodianE ?? "")
                   } label: {
                       PortfolioCell(portfolioData: item)
                   }

               }

            }
            .padding(.bottom, 80)
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
}


// MARK: - Model
struct PieSliceData: Identifiable {
    let id = UUID()
    var value: Double
    var color: Color
    var label: String
}

// MARK: - 3D Pie Chart
struct PieChart3DView: View {
    var data: [PieSliceData]
    var portfolioData: Binding<GetPortfolioUIModel?>

    @State private var selectedIndex: Int? = nil
    @State private var animationProgress: Double = 0

    private let depth: CGFloat = 22
    private let yScale: CGFloat = 0.42

    private var total: Double { data.reduce(0) { $0 + $1.value } }

    private func sliceAngles() -> [(start: Double, end: Double)] {
        var result: [(Double, Double)] = []
        var cursor: Double = -.pi / 2
        for d in data {
            let sweep = (total > 0 ? d.value / total : 0) * .pi * 2
            let clamped = max(sweep, (.pi * 2) * (10.0 / 360.0))
            result.append((cursor, cursor + clamped))
            cursor += clamped
        }
        return result
    }

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let cx = geo.size.width / 2
            let cy = geo.size.height * 0.46
            let rx = size * 0.36
            let ry = rx * yScale
            let angles = sliceAngles()

            ZStack {
                Canvas { context, _ in
                    let drawOrder = data.indices.sorted {
                        let ma = (angles[$0].start + angles[$0].end) / 2
                        let mb = (angles[$1].start + angles[$1].end) / 2
                        return sin(mb) < sin(ma)
                    }

                    // Side walls (back half first, then front)
                    for pass in 0...1 {
                        for i in drawOrder {
                            let mid = (angles[i].start + angles[i].end) / 2
                            let isFront = sin(mid) > 0
                            guard (pass == 0 && !isFront) || (pass == 1 && isFront) else { continue }
                            let lift: CGFloat = selectedIndex == i ? 10 : 0
                            drawSideWall(context: context,
                                         cx: cx, cy: cy - lift,
                                         rx: rx * animationProgress,
                                         ry: ry * animationProgress,
                                         depth: depth,
                                         start: angles[i].start,
                                         end: angles[i].end,
                                         color: data[i].color)
                        }
                    }

                    // Top faces
                    for i in drawOrder {
                        let lift: CGFloat = selectedIndex == i ? 10 : 0
                        drawTopFace(context: context,
                                     cx: cx, cy: cy - lift,
                                     rx: rx * animationProgress,
                                     ry: ry * animationProgress,
                                     start: angles[i].start,
                                     end: angles[i].end,
                                     color: data[i].color)
                    }
                }

                // Percentage labels on top faces
                ForEach(data.indices, id: \.self) { i in
                    let mid = (angles[i].start + angles[i].end) / 2
                    let lift: CGFloat = selectedIndex == i ? 10 : 0
                    let lx = cx + rx * 0.6 * animationProgress * cos(mid)
                    let ly = cy - lift + ry * 0.6 * animationProgress * sin(mid)
                    let pct = total > 0 ? data[i].value / total * 100 : 0

                    Text(String(format: "%.2f%%", pct))
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)
                        .position(x: lx, y: ly)
                }

                // Leader line labels
                ForEach(data.indices, id: \.self) { i in
                    let mid = (angles[i].start + angles[i].end) / 2
                    let lift: CGFloat = selectedIndex == i ? 10 : 0
                    let isRight = cos(mid) >= 0
                    let ex = cx + rx * 1.08 * animationProgress * cos(mid)
                    let ey = cy - lift + ry * 1.08 * animationProgress * sin(mid)

                    Path { path in
                        path.move(to: CGPoint(x: ex, y: ey))
                        let elbow = CGPoint(x: ex + cos(mid) * 14, y: ey + sin(mid) * 10)
                        path.addLine(to: elbow)
                        path.addLine(to: CGPoint(x: elbow.x + (isRight ? 18 : -18), y: elbow.y))
                    }
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)

                    Text(data[i].label)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.primary.opacity(0.75))
                        .position(
                            x: ex + cos(mid) * 14 + (isRight ? 36 : -36),
                            y: ey + sin(mid) * 10 - 8
                        )
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { value in
                        let tapX = value.location.x
                        let tapY = value.location.y
                        var tapped: Int? = nil
                        for i in data.indices {
                            let mid = (angles[i].start + angles[i].end) / 2
                            let dx = tapX - cx
                            let dy = tapY - (cy - (selectedIndex == i ? 10 : 0))
                            let nx = dx / rx, ny = dy / ry
                            if nx * nx + ny * ny <= 1.05 {
                                var a = atan2(dy, dx)
                                if a < -.pi / 2 { a += .pi * 2 }
                                var s = angles[i].start, e = angles[i].end
                                if s < -.pi / 2 { s += .pi * 2; e += .pi * 2 }
                                if a >= s && a <= e { tapped = i; break }
                            }
                        }
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                            selectedIndex = (selectedIndex == tapped) ? nil : tapped
                        }
                    }
            )
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.85)) {
                animationProgress = 1.0
            }
        }
    }

    // MARK: - Draw helpers

    private func drawSideWall(context: GraphicsContext,
                               cx: CGFloat, cy: CGFloat,
                               rx: CGFloat, ry: CGFloat,
                               depth: CGFloat,
                               start: Double, end: Double,
                               color: Color) {
        let steps = 40
        var topPoints: [CGPoint] = []
        var botPoints: [CGPoint] = []
        for i in 0...steps {
            let a = start + (end - start) * Double(i) / Double(steps)
            topPoints.append(CGPoint(x: cx + rx * Foundation.cos(a), y: cy + ry * sin(a)))
            botPoints.append(CGPoint(x: cx + rx * Foundation.cos(a), y: cy + ry * sin(a) + depth))
        }

        var path = Path()
        path.move(to: topPoints[0])
        topPoints.forEach { path.addLine(to: $0) }
        botPoints.reversed().forEach { path.addLine(to: $0) }
        path.closeSubpath()

        context.fill(path, with: .color(color.opacity(0.55)))
        context.stroke(path, with: .color(.white.opacity(0.12)), lineWidth: 0.8)
    }

    private func drawTopFace(context: GraphicsContext,
                              cx: CGFloat, cy: CGFloat,
                              rx: CGFloat, ry: CGFloat,
                              start: Double, end: Double,
                              color: Color) {
        var path = Path()
        path.move(to: CGPoint(x: cx, y: cy))
        let steps = 60
        for i in 0...steps {
            let a = start + (end - start) * Double(i) / Double(steps)
            path.addLine(to: CGPoint(x: cx + rx * Foundation.cos(a), y: cy + ry * sin(a)))
        }
        path.closeSubpath()
        context.fill(path, with: .color(color))
        context.stroke(path, with: .color(.white.opacity(0.25)), lineWidth: 1.2)
    }
}


// MARK: - Shape for a single slice
// MARK: - Shape for a single slice (with gap support)
struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var gapDegrees: Double = 0 // 👈 gap between slices

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

        // shrink each slice by half a gap on each side
        let adjustedStart = startAngle + Angle(degrees: gapDegrees / 2)
        let adjustedEnd   = endAngle   - Angle(degrees: gapDegrees / 2)

        path.move(to: center)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: adjustedStart - Angle(degrees: 90),
                    endAngle:   adjustedEnd   - Angle(degrees: 90),
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}

// MARK: - Pie Chart View
struct PieChartView: View {
    var data: [PieSliceData]
    var portfolioData: Binding<GetPortfolioUIModel?>
    var showPercentages: Bool = true
    var innerRadiusFraction: CGFloat = 0
    @State private var selectedSlice: UUID? = nil
    @State private var animate: Bool = false

    private var total: Double {
        data.reduce(0) { $0 + $1.value }
    }

    private func angles() -> [(data: PieSliceData, start: Double, end: Double)] {
        var result: [(PieSliceData, Double, Double)] = []
        
        let minDegrees: Double = 10.0 // 👈 minimum visible slice size
        
        // Calculate raw degrees for each slice
        var rawDegrees = data.map { d -> Double in
            let portion = (total > 0) ? (d.value / total) : 0
            return portion * 360
        }
        
        // Enforce minimum, then scale others down to compensate
        let totalMinClamped = rawDegrees.map { max($0, minDegrees) }.reduce(0, +)
        let scaleFactor = 360.0 / totalMinClamped
        
        var startAngle: Double = 0
        for (index, d) in data.enumerated() {
            let clamped = max(rawDegrees[index], minDegrees) * scaleFactor
            let end = startAngle + clamped
            result.append((d, startAngle, end))
            startAngle = end
        }
        
        return result
    }

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let pieRadius = size * 0.38

            ZStack {
                slicesView(size: size)
                labelsView(size: size, center: center, pieRadius: pieRadius)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    animate = true
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }

    // MARK: - Slices
    @ViewBuilder
    private func slicesView(size: CGFloat) -> some View {
        ForEach(angles(), id: \.data.id) { item in
            let isSelected = selectedSlice == item.data.id
            let midAngle = (item.start + item.end) / 2

            PieSlice(
                startAngle: .degrees(item.start),
                endAngle: .degrees(animate ? item.end : item.start)
            )
            .fill(item.data.color) // 👈 no stroke, no overlay
            .overlay(
                PieSlice(startAngle: .degrees(item.start), endAngle: .degrees(item.end))
                    .stroke(Color(hex: "#1C1C1C"), lineWidth: 1.5)
                    .opacity(0.6)
            )
            .offset(x: sliceOffsetX(isSelected: isSelected, midAngle: midAngle),
                    y: sliceOffsetY(isSelected: isSelected, midAngle: midAngle))
            .scaleEffect(isSelected ? 1.02 : 1.0)
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: selectedSlice)
            .onTapGesture {
                selectedSlice = selectedSlice == item.data.id ? nil : item.data.id
            }
        }

        if innerRadiusFraction > 0 {
            Circle()
                .fill(Color(.systemBackground))
                .frame(width: size * innerRadiusFraction, height: size * innerRadiusFraction)
        }
    }

    // MARK: - Labels
    @ViewBuilder
    private func labelsView(size: CGFloat, center: CGPoint, pieRadius: CGFloat) -> some View {
        ForEach(angles(), id: \.data.id) { item in
            leaderLineView(item: item, center: center, pieRadius: pieRadius)
            labelTextView(item: item, center: center, pieRadius: pieRadius)
        }
    }

    @ViewBuilder
    private func leaderLineView(item: (data: PieSliceData, start: Double, end: Double),
                                center: CGPoint,
                                pieRadius: CGFloat) -> some View {
        let midAngleRad = midRad(item: item)
        let edgePoint   = point(from: center, radius: pieRadius,        angleRad: midAngleRad)
        let elbowPoint  = point(from: center, radius: pieRadius * 1.25, angleRad: midAngleRad)
        let isRight     = cos(midAngleRad) >= 0
        let lineLength: CGFloat = 25
        let endPoint    = CGPoint(x: elbowPoint.x + (isRight ? lineLength : -lineLength), y: elbowPoint.y)

        Path { path in
            path.move(to: edgePoint)
            path.addLine(to: elbowPoint)
            path.addLine(to: endPoint)
        }
        .stroke(Color(hex: "#1C1C1C"), lineWidth: 1.5) // 👈 increased thickness
    }

    @ViewBuilder
    private func labelTextView(item: (data: PieSliceData, start: Double, end: Double),
                               center: CGPoint,
                               pieRadius: CGFloat) -> some View {
        let midAngleRad = midRad(item: item)
        let elbowPoint  = point(from: center, radius: pieRadius * 1.25, angleRad: midAngleRad)
        let isRight     = cos(midAngleRad) >= 0
        let lineLength: CGFloat = 35  // 👈 match leaderLineView
        let padding: CGFloat = 28
        let lineEndX    = elbowPoint.x + (isRight ? lineLength : -lineLength)
        let pct         = total > 0 ? item.data.value / total * 100 : 0
        let label       = "\(item.data.label): \(String(format: "%.2f", pct))%"

        Text(label)
            .font(.cairoFont(.semiBold, size: 13))
            .foregroundColor(.black)
            .fixedSize(horizontal: true, vertical: false)
            // align leading/trailing edge to the line tip + small padding
            .alignmentGuide(isRight ? .leading : .trailing) { _ in 0 }
            .position(
                x: lineEndX + (isRight ? padding : -padding),
                y: elbowPoint.y - 10 // 👈 sit above the line
            )
    }
    // MARK: - Helpers
    private func midRad(item: (data: PieSliceData, start: Double, end: Double)) -> CGFloat {
        let midDeg = (item.start + item.end) / 2
        return CGFloat((midDeg - 90) * .pi / 180)
    }

    private func point(from center: CGPoint, radius: CGFloat, angleRad: CGFloat) -> CGPoint {
        CGPoint(
            x: center.x + cos(angleRad) * radius,
            y: center.y + sin(angleRad) * radius
        )
    }

    private func sliceOffsetX(isSelected: Bool, midAngle: Double) -> CGFloat {
        guard isSelected else { return 0 }
        return 8 * cos(CGFloat((midAngle - 90) * .pi / 180))
    }

    private func sliceOffsetY(isSelected: Bool, midAngle: Double) -> CGFloat {
        guard isSelected else { return 0 }
        return 8 * sin(CGFloat((midAngle - 90) * .pi / 180))
    }
}
