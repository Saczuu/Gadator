//
//  NewConversationRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

class NewConversationRouter {
    var presenter: NewConversationPresenter!
    var coordinator: Coordinator!
    
    func goBackToListOfMessage() {
        return self.coordinator.switchToListOfMessageView()
    }
    
    func goToChatView(chat: FirebaseChat) {
        self.coordinator.switchToConversationView(with: chat)
    }
}
