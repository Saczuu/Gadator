//
//  ConversationRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

class ConversationRouter: RouterInterface {
    var presenter: ConversationPresenterRouterInterface!
    var coordinator: Coordinator!
}
extension ConversationRouter: ConversationRouterPresenterInterface {
    func goToListOfMessageView() {
        self.coordinator.switchToListOfMessageView()
    }
}
