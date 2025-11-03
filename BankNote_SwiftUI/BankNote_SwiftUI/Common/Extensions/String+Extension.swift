//
//  String+Extension.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        var language = "en"
        
        if Thread.current.isMainThread{
            @Inject var userDefaultController: UserDefaultController?
            if userDefaultController?.isArabicLanguage ?? false {
                language = "ar"
            }
        }else{
            print("localized faild becuse it invloked on Backgorund threads!!!")
        }
        
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        let bundle = Bundle(path: path!)
        guard let string = bundle?.localizedString(forKey: self, value: nil, table: nil)else { return "" }
        return string
    }
    
    var isOnlyNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    
    var isOnlyDecimalNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789.")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
    var isOnlyEnglishCharacters: Bool {
        return "ABCDEFGHIJKLMNOPQRSTUVWXYZ".lowercased().contains(self.lowercased())
    }
    
    var firstUppercasedForAllWords: String {
        if self.contains(" ") {
            let wordArray = self.split(separator: " ")
            var wordValue = ""
            wordArray.forEach({ word in
                wordValue +=   word.prefix(1).capitalized + word.dropFirst() + " "
            })
            return String( wordValue.dropLast())
        }else{
            return prefix(1).capitalized + dropFirst()
        }
    }
    
    var arToEnDigits : String {
        let arabicNumbers = ["٫" : ".", "٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        _=arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }

    
    func replace_fromStart(str: String, endIndex: Int, With: String) -> String {
        var strReplaced = str
        let start = str.startIndex
        let end = str.index(str.startIndex, offsetBy: endIndex)
        strReplaced = str.replacingCharacters(in: start..<end, with: With)
        return strReplaced
    }
    
    func stringByAddingPercentEncodingToData() -> String? {
       let finalString = self.replacingOccurrences(of: "+", with: "%2B")
       return finalString
   }
    
    func convertHTMLToPlainText() -> String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        ) else {
            return nil
        }
        
        return attributedString.string
    }
    
    var isEmptyStr: Bool{
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isArabic: Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", "(?s).*\\p{Arabic}.*")
        return predicate.evaluate(with: self)
    }
    
}
