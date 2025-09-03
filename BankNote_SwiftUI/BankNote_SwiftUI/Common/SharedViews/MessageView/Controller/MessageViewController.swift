//
//  MessageViewController.swift
//  QSC
//
//  Created by FIT on 16/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//


import Foundation
import UIKit
import SwiftUI

class MessageViewController{
    static let instance:MessageViewController = MessageViewController()
    
    private var noInternetMessageTag: Int { 91238923 }
    private var canShowInternetMessage: Bool = false

    private var queueMessageViews: [CustomMessageView] = []
    private  let  showDuration: TimeInterval = 1
    private  let  removeDuration: TimeInterval = 0.5
    private  let  delayRemoveDuration: TimeInterval = 2
    private  var  pauseBetweenMessages: TimeInterval{
        get{
            return showDuration + removeDuration
        }
    }
    
    fileprivate var _currentMessageView: CustomMessageView? = nil {
        didSet {
            if oldValue != nil {
                Task { [weak self] in
                    try? await Task.sleep(seconds: self?.pauseBetweenMessages ?? 0)
                    self?.dequeueNext()
                }
            }
        }
    }
    
    
    
    fileprivate func dequeueNext() {
        guard queueMessageViews.count > 0 else { return }
        
        // Skip persistent messages unless explicitly dismissed
            if let current = queueMessageViews.first, current.persistent, !current.isFinish {
                print("Skipping persistent message: \(current.tag)")
                return
            }
        
        if let _currentMessageView, !_currentMessageView.isFinish { return }
        let current = queueMessageViews.removeFirst()
        self._currentMessageView = current
        guard let window = SceneDelegate.getAppCoordinator()?.getWindow() else{return}
        
        window.addSubview(current)
        current.addConstraint( leading:0, top: 0, trailing: 0)
        current.superview?.bringSubviewToFront(current)
        self.showAnimation(view: current, isPersistent: current.tag == noInternetMessageTag)
    }
    
    
    
    func show(_ type:MessageViewType = .success,text:String, onTap:(()->Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            let customMessageView:CustomMessageView = .fromNib()
            customMessageView.setTitle(text, type: type)
            customMessageView.onViewTap = {
                [weak self] in
                onTap?()
                self?.removeAnimation(view: customMessageView,complete:{
                    customMessageView.isFinish = true
                    self?.dequeueNext()
                })
            }
            self?.queueMessageViews.append(customMessageView)
            self?.dequeueNext()
        }
    }
    
    /// Show a persistent "No Internet" message
       func showNoInternetMessage() {
           if !canShowInternetMessage {
               canShowInternetMessage = true
               return
           }
           
           DispatchQueue.main.async { [weak self] in
               guard let self = self else { return }

               // Avoid duplicate "No Internet" messages
               if self.queueMessageViews.contains(where: { $0.tag == self.noInternetMessageTag }) {
                   return
               }

               let customMessageView: CustomMessageView = .fromNib()
                customMessageView.setTitle("No Internet Connection", type: .failure)
               customMessageView.tag = self.noInternetMessageTag
               customMessageView.persistent = true
//               customMessageView.onViewTap = { [weak self] in
                   // No action on tap for this message
//               }

               // Add the message to the queue
               self.queueMessageViews.append(customMessageView)

              // Directly display the message
              guard let window = SceneDelegate.getAppCoordinator()?.getWindow() else { return }
              window.addSubview(customMessageView)
              customMessageView.addConstraint(leading: 0, top: 0, trailing: 0)
              customMessageView.superview?.bringSubviewToFront(customMessageView)
              self.showAnimation(view: customMessageView, isPersistent: true)
//               self.dequeueNext()
           }
       }

       /// Dismiss the persistent "No Internet" message and optionally show a "Connected" message
       func dismissNoInternetMessage(showConnectedMessage: Bool = true) {
           DispatchQueue.main.async { [weak self] in
               guard let self = self else { return }
               print("Attempting to dismiss the 'No Internet' message...")

               // Find and remove the "No Internet" message
               if let index = self.queueMessageViews.firstIndex(where: { $0.tag == self.noInternetMessageTag }) {
                   print("Found 'No Internet' message at index \(index). Removing it.")

                   let messageView = self.queueMessageViews.remove(at: index)
                   self.removeAnimation(view: messageView) {
                       print("'No Internet' message animation completed.")

                       messageView.isFinish = true
                       self.dequeueNext()
                   }
               } else {
                   print("'No Internet' message not found in the queue.")
               }

               // Optionally show a "Connected" message
               if !canShowInternetMessage {
                   canShowInternetMessage = true
                   return
               }
               
               if showConnectedMessage {
                   print("Showing 'Internet Connected' message.")

                   self.show(.success, text: "Internet Connected")
               }
           }
       }

    func showAlertMessage(text:String,viewAlertTitle:String = "view".localized,onTap:(()->Void)?) {
        DispatchQueue.main.async { [weak self] in
            let customMessageView:CustomMessageView = .fromNib()
            customMessageView.setTitle(text,viewAlertTitle:viewAlertTitle, type: .alert)
            customMessageView.onViewTap = {
                [weak self] in
                self?.removeAnimation(view: customMessageView,complete:{
                    customMessageView.isFinish = true
                    self?.dequeueNext()
                })
            }

            customMessageView.onAlertViewTap = {
                [weak self] in
                self?.removeAnimation(view: customMessageView,complete:{
                    customMessageView.isFinish = true
//                    self?.dequeueNext()
                    onTap?()
                })
            }

            self?.queueMessageViews.append(customMessageView)
            self?.dequeueNext()
        }
    }

    private func showAnimation(view: CustomMessageView, isPersistent: Bool = false) {
        view.frame.origin.y = -view.bounds.height
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: showDuration, delay: 0, options: [.curveEaseIn], animations: {
            view.frame.origin.y = 0
            view.layoutIfNeeded()
        }, completion: { _ in
            // Only auto-remove if the message is not persistent
            if !isPersistent {
                DispatchQueue.main.asyncAfter(deadline: .now() + self.delayRemoveDuration) { [weak self] in
                    self?.removeAnimation(view: view, complete: {
                        view.isFinish = true
                        self?.dequeueNext()
                    })
                }
            }
        })
    }

    private func removeAnimation(view:UIView,complete:@escaping(()->Void)) {
        UIView.animate(withDuration: removeDuration, delay: 0, options: [.curveLinear],
                       animations: {
            view.frame.origin.y = -view.bounds.height
            view.layoutIfNeeded()
        },  completion: {(_ completed: Bool) -> Void in
            view.removeFromSuperview()
            complete()
        })
    }

}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: TimeInterval) async throws {
        try await sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}


