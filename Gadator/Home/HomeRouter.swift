//
//  HomeRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI

final class HomeRouter: RouterInterface {
    
    typealias PresenterRouter = HomePresenterRouterInterface
    typealias CoordinatorRouter = Coordinator
    
    var coordinator: CoordinatorRouter!
    var presenter: PresenterRouter!
    
}

extension HomeRouter: HomeRouterPresenterInterface {
    func goToRegisterView() {
        coordinator.switchToRegisterView()
    }
    
    func goToListOfMessageView() {
        coordinator.switchToListOfMessageView()
    }
}
