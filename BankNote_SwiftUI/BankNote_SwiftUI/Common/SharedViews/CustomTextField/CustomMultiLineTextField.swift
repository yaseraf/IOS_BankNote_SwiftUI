//
//  CustomMultiLineTextField.swift
//  QSC
//
//  Created by FIT on 05/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomMultiLineTextField: View {
    // Parameters for the title and the placeholder text
    // Parameters for title, text binding, and max height
      let title: String
      let maxHeight: CGFloat // Maximum height passed via the constructor
     var inputValue: Binding<String>
    var onTextChange:(()->Void)
    @State private var textHeight: CGFloat = 154 // Initial height

    init(title: String,inputValue: Binding<String>, maxHeight: CGFloat , onTextChange:@escaping (()->Void)) {
        self.title = title
        self.maxHeight = maxHeight
        self.inputValue = inputValue
        self.onTextChange = onTextChange
     }

      var body: some View {
          VStack(alignment: .leading, spacing: 0) {


              // Multi-line text editor with dynamic height
              ZStack(alignment: .topLeading) {
                  // Placeholder text, shown only when the input is empty
                  Text(title)
                      .foregroundStyle( Color.colorTextPlaceHolder)
                      .font(getFont(text: inputValue.wrappedValue))
                      .scaleEffect(scaleEffectValue, anchor: .leading)

                  // Editable text field
                  TextEditor(text: inputValue)
                      .font(.apply(.semiBold,size: 17))
                      .transparentScrolling()
                      .background(.clear)
                      .padding(.top,18)

                      .frame(minHeight: textHeight, maxHeight: min(textHeight, maxHeight)) // Constrain to max height
                      .onChange(of: inputValue.wrappedValue) { _ in
                          updateTextHeight()
                          onTextChange()
                      }
              }
          }
          .padding(.horizontal,16)
          .padding(.vertical,8)
          .background(
              RoundedRectangle(cornerRadius: 14)
                  .stroke(Color.colorBorderPrimary, lineWidth: 1)
          )
          .background(
              RoundedRectangle(cornerRadius: 14)
                  .fill(Color.colorBGTertiary)
          )
      }

      // Function to update text height dynamically
      private func updateTextHeight() {

          // Measure the height of the text content
          let textSize = CGSize(width: UIScreen.main.bounds.width - 32, height: .greatestFiniteMagnitude)
          let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
          let boundingRect = NSString(string: inputValue.wrappedValue).boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
          let newHeight = min(max(textHeight, boundingRect.height + 24), maxHeight)
          self.textHeight = newHeight // Update height dynamically but within the maximum height
      }


    func getScaleEffectValue(text:String) -> CGFloat {

        return text.isEmpty ? 1 : 0.75
    }

    func getFont(text:String) -> Font {

        return text.isEmpty ? Font.apply(size: 17) : Font.apply(size:11)
    }
    
    var scaleEffectValue: CGFloat {
        get{
            getScaleEffectValue(text: inputValue.wrappedValue)
        }
    }
}
public extension View {
    func transparentScrolling() -> some View {
        if #available(iOS 16.0, *) {
            return scrollContentBackground(.hidden)
        } else {
            return onAppear {
                UITextView.appearance().backgroundColor = .clear
            }
        }
    }
}

#Preview {
         CustomMultiLineTextField(title: "Title", inputValue: .constant(""),maxHeight: 150,onTextChange:{})
        .previewLayout(.sizeThatFits)
        .padding()

}
