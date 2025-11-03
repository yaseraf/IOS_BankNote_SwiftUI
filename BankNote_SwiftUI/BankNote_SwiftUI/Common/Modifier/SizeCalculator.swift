//
//  SizeCalculator.swift
//  QSC
//
//  Created by FIT on 30/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct SizeCalculator: ViewModifier {

    @Binding var size: CGSize
    let  tag: String
var onUpdate:((CGSize)->Void)?
    func body(content: Content) -> some View {
        content
                .background(
                    GeometryReader { geometry in
                        Color.clear // Invisible color to force the reader to take size
                            .onAppear {
                                self.size = geometry.size // Capture the size when it appears
//                                debugPrint("proxy.size onAppear \(tag):\(size) ")
                                onUpdate?(size)

                            }
                            .onChange(of: geometry.size) { newSize in
                                self.size = newSize // Update size when it changes
//                                debugPrint("proxy.size onChange \(tag):\(size) ")
                                onUpdate?(size)
                            }
                    }
                )

    }
}

extension View {
    func saveSize(in size: Binding<CGSize>,tag: String,onUpdate:((CGSize)->Void)? = nil) -> some View {
        modifier(SizeCalculator(size: size,tag: tag,onUpdate:onUpdate))
    }
}
