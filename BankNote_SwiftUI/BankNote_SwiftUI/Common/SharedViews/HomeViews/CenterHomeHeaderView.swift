//
//  CustomHomeHeaderView.swift
//  QSC
//
//  Created by FIT on 19/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct CenterHomeHeaderView<LeftView: View,CenterView: View>: View {

    var viewLeft: (() -> LeftView)
    var viewCenter: (() -> CenterView)

    var body: some View {
        HStack {
            viewLeft()
            Spacer()
            viewCenter()
            Spacer()
            viewLeft()
                .disabled(false)
                .opacity(0)
        }
    }
}
