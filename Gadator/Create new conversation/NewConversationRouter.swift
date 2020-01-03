//
//  NewConversationRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

class NewConversationRouter: RouterInterface {
    var presenter: NewConversationPresenterRouterInterface!
    var coordinator: Coordinator!
}
extension NewConversationRouter: NewConversationRouterPresenterInterface{
    func goBackToListOfMessage() {
        return self.coordinator.switchToListOfMessageView()
    }
    
    func goToChatView(chat: FirebaseChat) {
        return self.coordinator.switchToConversationView(with: chat)
    }
}
