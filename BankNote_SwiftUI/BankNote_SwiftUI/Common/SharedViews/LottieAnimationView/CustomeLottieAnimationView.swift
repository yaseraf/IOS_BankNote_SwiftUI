//
//  CustomeLottieAnimationView.swift
//  QSC
//
//  Created by FIT on 09/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI
import Lottie
struct CustomLottieAnimationView:UIViewRepresentable{
    let fileName:LottieFileName
    let loopMode:LottieLoopMode
    init(fileName: LottieFileName,loopMode:LottieLoopMode) {
        self.fileName = fileName
        self.loopMode = loopMode
    }
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView(name:fileName.rawValue)

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])


        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }


}
