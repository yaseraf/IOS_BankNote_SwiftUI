//
//  AuthHeaderView.swift
//  QSC
//
//  Created by FIT on 23/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct AuthHeaderView: View ,BaseContentViewType{


    enum AuthHeaderType{
        case logo
        case back(BackMode)
        case none
        enum BackMode{
            case pop
            case dismiss
        }
    }
    var type :AuthHeaderType
    var showLanguage :Bool
    init(type: AuthHeaderType, showLanguage:Bool = true) {
        self.type = type
        self.showLanguage = showLanguage

    }

    var body: some View {
        HStack{
            Button(action: {
//                self.onBack?()
                switch type {
                case .logo:
                    break
                case .back(let backMode):
                    switch backMode{
                    case .pop:
                        SceneDelegate.getAppCoordinator()?.goBack()
                    case.dismiss:
                        SceneDelegate.getAppCoordinator()?.topViewController()?.dismiss(animated: true)
                    }
                case .none:
                    break
                }


            }, label: {
                switch type {
                case .logo:
                    AuthLogoSmallView()
                case .back:
                  BackCustomView()
                case .none:
                    EmptyView()
                }

            })
            Spacer()
            if showLanguage{
                LanguageHeaderView()
            }
        }.frame(maxWidth: .infinity)
    }


}

#Preview {
    Group{
        AuthHeaderView(type: .logo)
        AuthHeaderView(type: .back(.dismiss))
    }
}
