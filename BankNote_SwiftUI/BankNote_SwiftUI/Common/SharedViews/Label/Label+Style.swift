//
//  Label+Style.swift
//  QSC
//
//  Created by FIT on 17/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomLabel: LabelStyle {
    var spacing: Double = 0.0
    var reverse: Bool = true

    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: spacing) {
            if reverse{
                configuration.title
                configuration.icon
            }else{
                configuration.icon
                configuration.title

            }

        }
    }
}
