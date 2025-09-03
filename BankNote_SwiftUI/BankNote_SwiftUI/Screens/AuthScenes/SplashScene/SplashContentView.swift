//
//  SplashView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/07/2025.
//

import Foundation
import SwiftUI

struct SplashContentView: View {    
    var body: some View {
        ZStack{
            
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .padding(20)
        }
    }
}
