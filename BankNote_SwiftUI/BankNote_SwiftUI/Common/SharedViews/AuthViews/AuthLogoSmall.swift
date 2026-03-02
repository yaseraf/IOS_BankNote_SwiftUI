//
//  AuthLogoSmall.swift
//  QSC
//
//  Created by FIT on 04/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
struct AuthLogoSmallView:View{
    var body: some View{
        Image(AppUtility.shared.APP_LOGO)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 120, maxHeight: 120)
    }
}
