//
//  CustomMessageView.swift
//  QSC
//
//  Created by FIT on 16/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//



import UIKit
import SwiftUI


class CustomMessageView: UIView {
    var isFinish = false
    var persistent = false
    @IBOutlet private weak var lblAlertTitle: UILabel!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var viewBackground: UIView!
    @IBOutlet private weak var imgVIcon: UIImageView!
    @IBOutlet weak var trailingTitle: NSLayoutConstraint!
    
    var onViewTap:(()->Void)?
    var onAlertViewTap:(()->Void)?

    private var type:MessageViewType = .success{
        didSet{
            switch type {
            case .success:
//                viewBackground.backgroundColor = Color.colorSuccess_26A95F.uiColor()
                viewBackground.backgroundColor = Color.colorPrimary.uiColor()
                lblAlertTitle.superview?.isHidden = true


            case .failure:
                viewBackground.backgroundColor =  Color.colorError.uiColor()
                lblAlertTitle.superview?.isHidden = true

            case .alert:
                viewBackground.backgroundColor = Color.colorSuccess_26A95F.uiColor()
                lblAlertTitle.superview?.isHidden = false
                trailingTitle.constant = (lblAlertTitle.superview?.bounds.width  ?? 0 ) + 16
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        lblAlertTitle.superview?.isHidden = true
    }
    


    private func setupUI() {
        self.backgroundColor  = .clear
        lblTitle.font = .cairoFont(.semiBold, size: 15)
        lblTitle.textColor = .white
        imgVIcon.tintColor = .white

        lblAlertTitle.font = .cairoFont(.semiBold, size: 15)
        lblAlertTitle.textColor = .white


    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        viewBackground.layer.cornerRadius = 16
        viewBackground.addBottomShadow()
        if let view = lblAlertTitle.superview {
            view.layer.cornerRadius = view.bounds.height / 2
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 1
        }

    }
    
 
    func setTitle(_ message:String,viewAlertTitle:String = "" ,type:MessageViewType = .success) {
        lblTitle.text = message
        lblAlertTitle.text = viewAlertTitle
        self.type = type
    }
    
    @IBAction private func viewAction(_ sender: Any) {
        onViewTap?()
    }
       @IBAction private func alertViewAction(_ sender: Any) {
           onAlertViewTap?()
    }
    
}

