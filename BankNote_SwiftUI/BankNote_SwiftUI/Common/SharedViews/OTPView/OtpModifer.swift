//
//  OtpModifer.swift
//  QSC
//
//  Created by FIT on 04/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct OtpModifer: ViewModifier {

    @Binding var pin : String

    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count >= upper {
            if pin.contains("-"){
                pin = pin.replacingOccurrences(of: "-", with: "")
            }
            self.pin = String(pin.suffix(upper))
        }
    }


    //MARK -> BODY
    func body(content: Content) -> some View {
             content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: (UIScreen.main.bounds.width / 6) - (32 / 4) , height: 54)
            .font(.apply(size: 28))
            .foregroundColor(.colorTextPrimary)


    }
}
