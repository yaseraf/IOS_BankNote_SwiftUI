//
//  HTMLView.swift
//  mahfazati
//
//  Created by FIT on 17/03/2025.
//  Copyright © 2025 Mohammed Mathkour. All rights reserved.
//

import SwiftUI
import UIKit
import WebKit

struct HTMLTextView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textContainer.lineBreakMode = .byWordWrapping // Enable word wrapping for multiline
        textView.textContainerInset = .zero // Remove extra padding around the text
        textView.textContainer.lineFragmentPadding = 0 // Remove padding between lines
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        // Ensure the HTML content is correctly formatted to include <p> and <br> tags
        let formattedHtml = """
            <style>
                body { font-size: 16px; line-height: 1.5; margin: 0; padding: 0; }
                p { margin-bottom: 10px; }
                br { line-height: 1.5; }
            </style>
            \(htmlContent)
        """
        
        if let data = formattedHtml.data(using: .utf8) {
            let attributedString = try? NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            textView.attributedText = attributedString
        }
    }
}
