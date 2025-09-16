//
//  SegmentsView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import SwiftUI

struct SegmentsView: View {
    
    @State var stepNumber: Int = 0
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0...5, id: \.self) { index in
                if stepNumber > index {
                    LinearGradient( gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]), startPoint: .leading, endPoint: .trailing)
                    
                        .cornerRadius(12)
                } else {
                    RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#DDDDDD"))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 6)
        .padding(.horizontal, 18)

    }
}
