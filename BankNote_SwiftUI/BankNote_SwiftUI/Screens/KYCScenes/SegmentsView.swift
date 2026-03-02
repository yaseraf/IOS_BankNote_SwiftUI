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
                    AppUtility.shared.APP_GRADIENT
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
