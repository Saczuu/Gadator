//
//  RegisterRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

class RegisterRouter: RouterInterface {
    
    var coordinator: Coordinator!
    var presenter: RegisterPresenterRouterInterface!
}
extension RegisterRouter: RegisterRouterPresenterInterface {
    func goToLoginView() {
        return coordinator.switchToLoginView()
    }
}
