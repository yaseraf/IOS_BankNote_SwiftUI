//
//  SeperatorCustomView.swift
//  QSC
//
//  Created by FIT on 24/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct SeparatorCustomView: View {
    let color:Color
    init(color: Color = Color.colorBorderSecondary) {
        self.color = color
    }
    var body: some View {
        Rectangle()
            .fill(Color.colorBorderSecondary)
            .frame(maxWidth: .infinity)
            .frame(height: 1)

    }
}

#Preview {
    SeparatorCustomView()
}
