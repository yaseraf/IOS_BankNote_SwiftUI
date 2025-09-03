//
//  HTMLTextView.swift
//  QSC
//
//  Created by FIT on 05/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

import WebKit
import SwiftUI
struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    let font: String   // Font name as a string
    let fontSize: CGFloat // Font size
    let textColor: String // Text color in hex format or named color

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Modify the HTML string to include style tags with the specified font, size, and color
        let styledHTML = """
        <html>
        <head>
        <style>
            body {
                font-family: '\(font)';
                font-size: \(fontSize)px;
                color: \(textColor);
                margin: 0;
                padding: 0;
                background-color: transparent;  /* Make the HTML body background transparent */

            }
        </style>
        </head>
        <body>
        \(htmlContent)
        </body>
        </html>
        """
        uiView.backgroundColor = .clear
        uiView.isOpaque = false
        uiView.loadHTMLString(styledHTML, baseURL: nil)
    }
}


