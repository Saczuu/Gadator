//
//  RegisterRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

class RegisterRouter {
    var coordinator: Coordinator!
    
    func goToLoginView() {
        return coordinator.switchToLoginView()
    }
}
