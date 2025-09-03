//
//  CandlestickView.swift
//  QSC
//
//  Created by FIT on 26/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

import SwiftUI


struct CandlestickView: View {
    let data: CandlestickData
    let maxY: Double
    let minY: Double
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        let scaleY = height / CGFloat(maxY - minY)
        let openY = CGFloat(maxY - data.open) * scaleY
        let closeY = CGFloat(maxY - data.close) * scaleY
        let highY = CGFloat(maxY - data.high) * scaleY
        let lowY = CGFloat(maxY - data.low) * scaleY

        let color = data.open > data.close ? Color.red : Color.green

        return VStack(spacing: 2) {
            Canvas { context, size in
                // Wick (High to Low)
                context.stroke(Path { path in
                    path.move(to: CGPoint(x: size.width / 2, y: highY))
                    path.addLine(to: CGPoint(x: size.width / 2, y: lowY))
                }, with: .color(color), lineWidth: 1)

                // Body (Open to Close)
                let candleRect = CGRect(
                    x: size.width / 2 - width / 2,
                    y: min(openY, closeY),
                    width: width,
                    height: abs(openY - closeY)
                )
                context.fill(Path(candleRect), with: .color(color))
            }
            .frame(width: width, height: height)

        }
    }
}

struct CandlestickChartView: View {
    let data: [CandlestickData]
    let maxY:Double
    let minY:Double
    let candleWidth: CGFloat
    let widthItem: CGFloat
    let candleHeight: CGFloat
    let spacing: CGFloat
    init(data: [CandlestickData]) {
        self.data = data

         maxY = ( data.map { $0.high }.max() ?? 0) + 1
         minY = data.map { $0.low }.min() ?? 0
         candleWidth = 6
         candleHeight = 200
         spacing = 8
         widthItem = UIScreen.main.bounds.width / 6
    }
    var body: some View {
        ZStack {
            gridViews.padding(.bottom,20)
            
                    ScrollView(.horizontal) {
                        HStack(alignment: .bottom, spacing: spacing) {

                            ForEach(data, id: \.id) { candlestick in
                                VStack{
                                    CandlestickView(
                                        data: candlestick,
                                        maxY: maxY,
                                        minY: minY,
                                        width: candleWidth,
                                        height: candleHeight
                                    )
                                    Text(candlestick.date)
                                        .font(.apply(size:11))
                                        .foregroundColor(.gray)
                                        .padding(.top,20)
                                }
                                .frame(width:  widthItem)
                            }
                        }
                    }.padding(.leading,20)

        }
    }

    private var gridViews:some View{

        // Grid lines
        VStack {
            ForEach(0..<5) { i in
                Spacer()
                HStack {
                    Text("EGP \(Int(maxY) * (4 - i) / 4)")
                        .font(.apply(size:11))
                        .foregroundColor(.gray)

                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                }.frame(maxWidth: .infinity,alignment: .leading)

            }
        }
        .frame(height: candleHeight)
        }


}


#Preview {
    let sampleData = [
        CandlestickData(open: 13.2, close: 13, high: 15.5, low: 12.1, date: "Apr 1"),
        CandlestickData(open: 14.4, close: 13.3, high: 16.6, low: 13.2, date: "Apr 2"),
        CandlestickData(open: 13.3, close: 15.5, high: 17, low: 13.3, date: "Apr 3"),
        CandlestickData(open: 15.5, close: 13.2, high: 16.6, low: 12.1, date: "Apr 4"),
        CandlestickData(open: 13.2, close: 14.5, high: 15.7, low: 12.2, date: "Apr 5"),
        CandlestickData(open: 14.5, close: 13.1, high: 16.0, low: 13.0, date: "Apr 6"),

        // Add more sample data to test scrolling
    ]
    return CandlestickChartView(data: sampleData)
        .frame(height: 250)
}
