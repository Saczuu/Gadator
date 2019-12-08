//
//  HomeRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI

final class HomeRouter {
    var coordinator: Coordinator!
    
    func goToRegisterView() {
        coordinator.switchToRegisterView()
    }
    
    func goToListOfMessageView() {
        coordinator.switchToListOfMessageView()
    }
}
