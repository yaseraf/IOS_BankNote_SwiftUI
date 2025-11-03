//
//  GrabberView.swift
//  QSC
//
//  Created by FIT on 02/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct GrabberView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 99)
            .frame(width: 42)
            .frame(height: 5)
            .foregroundColor(Color.colorQuaternary)
    }
}

#Preview {
    GrabberView()
}
