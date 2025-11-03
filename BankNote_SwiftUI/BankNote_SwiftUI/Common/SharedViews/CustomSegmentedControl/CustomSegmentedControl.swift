//
//  CustomSegmentedControl.swift
//  QSC_SwiftUI
//
//  Created by FIT on 05/08/2025.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selectedIndex: Int
    let segments: [String]

    @Namespace private var animation

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let segmentWidth = totalWidth / CGFloat(segments.count)

            ZStack(alignment: .leading) {
                // Background
                Capsule()
                    .fill(Color.colorBGSelection)
                
                // Sliding selected capsule
                Capsule()
                    .fill(Color.colorBG)
                    .frame(width: segmentWidth - 4, height: 44)
                    .offset(x: CGFloat(selectedIndex) * segmentWidth + 2)
                    .animation(.easeInOut(duration: 0.3), value: selectedIndex)

                HStack(spacing: 0) {
                    ForEach(segments.indices, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                selectedIndex = index
                            }
                        }) {
                            Text(segments[index])
                                .font(.apply(.medium, size: 14))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundColor(selectedIndex == index ? Color.colorTextPrimary : .gray)
                        }
                        .frame(width: segmentWidth, height: 44)
                    }
                }
            }
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(Color.colorBGSelection, lineWidth: 1)
            )
        }
        .frame(height: 48)
        .padding(.horizontal, 20)
    }
}


//struct CustomSegmentedControl: View {
//    @Binding var selectedIndex: Int
//    let segments: [String]
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(segments.indices, id: \.self) { index in
//                Text(segments[index])
//                    .font(.apply(.medium, size: 14))
//                    .foregroundColor(selectedIndex == index ? .black : .gray)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 10)
//                    .background(
//                        Group {
//                            if selectedIndex == index {
//                                withAnimation {
//                                    Color.white
//                                }
//                            } else {
//                                withAnimation {
//                                    Color.clear
//                                }
//                            }
//                        }
//                    )
//                    .clipShape(Capsule())
//                    .onTapGesture {
//                        selectedIndex = index
//                    }
//            }
//        }
//        .padding(4)
//        .background(Color(hex: "#F3F3F5"))
//        .clipShape(Capsule())
//        .overlay(
//            Capsule()
//                .stroke(Color(UIColor.systemGray4), lineWidth: 1)
//        )
//        .padding(.horizontal, 20)
//    }
//}
