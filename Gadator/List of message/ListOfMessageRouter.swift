//
//  ListOfMessageRouter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

class ListOfMessageRouter {
    var coordinator: Coordinator!
    
    func goToChatView(chat: FirebaseChat) {
        self.coordinator.switchToConversationView(with: chat)
    }
    
    func goToNewConversationView(userList: [FirebaseUser]) {
        self.coordinator.switchToNewConversationView(userList: userList)
    }
}
