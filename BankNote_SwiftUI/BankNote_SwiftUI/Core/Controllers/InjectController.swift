//
//  InjectController.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import Swinject
class InjectController {
    static let shared: InjectController = .init()
    let container = Container()

    func setupAll() {
// setup cach user default controller
        container.register(UserDefaultController.self) { _ in
            return UserDefaultController()
        }

        container.register(KeyChainController.self) { _ in
            return KeyChainController()
        }

    }
}

@propertyWrapper
struct Inject<T> {
    var wrappedValue: T? {
        return InjectController.shared.container.resolve(T.self)
    }
}
