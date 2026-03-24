//
//  PaymobViewController.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 03/03/2026.
//

import Foundation
import UIKit
import PaymobSDK

class PaymobViewController: NSObject, ObservableObject {
    
    static let shared = PaymobViewController()
    
    let paymob = PaymobSDK()
    
    // Replace this string with your payment key
    
    let public_key = "egy_pk_test_9D0FXtxbtGQe6HfHc0MCotwQcykQlhQa" // Put Public Key Here

    
    func initiatePayment() {
//        do{
//            debugPrint("Trying to present paymob")
//            try paymob.presentPayVC(VC: self, PublicKey: public_key, ClientSecret: client_secret)
//        } catch let error {
//            debugPrint("Could not initialte payment through paymob")
//        }
    }
    
    func presentPaymob(vc:UIViewController?, clientSecret: String) {
        guard let vc = vc else {
            debugPrint("No view controller found")
            return
        }
        
//        paymob.delegate = self
        
        
        debugPrint("Viewcontr: \(vc)")
        
        do {
            try paymob.presentPayVC(
                VC: vc ,
                PublicKey: public_key,
                ClientSecret: clientSecret
            )
        } catch {
            debugPrint("paymob error received: \(error)")
        }

            // Use modern Scene-based API for iOS 13+ compatibility (fixes iOS 18 crash)
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let rootVC = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController ?? windowScene.windows.first?.rootViewController {
//                
//                try? self.paymob.presentPayVC(
//                    VC: vc,
//                    PublicKey: self.public_key,
//                    ClientSecret: self.client_secret
//                )
//                
//                debugPrint("Trying to present paymob")
//            } else {
//                debugPrint("Could not initialte payment through paymob")
//            }
        


//        guard let rootVC = UIApplication.shared
//            .connectedScenes
//            .compactMap({ $0 as? UIWindowScene })
//            .first?
//            .windows
//            .first?
//            .rootViewController else { return }
//
//        try? paymob.presentPayVC(
//            VC: rootVC,
//            PublicKey: public_key,
//            ClientSecret: client_secret
//        )
    }
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PaymobViewController: PaymobSDKDelegate {
    func transactionRejected(message: String) {
        debugPrint("Transaction Rejected: \(message)")
    }

    func transactionAccepted(transactionDetails: [String : Any]) {
        debugPrint("Transaction Successfull: \(transactionDetails)")
    }

    func transactionPending() {
        debugPrint("Transaction Pending")
    }
}
