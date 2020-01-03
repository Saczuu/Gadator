//
//  ConversationPresenter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation

class ConversationPresenter: PresenterInterface {
    var viewModel: ConversationViewModel!
    var router: ConversationRouterPresenterInterface!
    var interactor: ConversationInteractorPresenterInterface!
    var chat: FirebaseChat!
}

extension ConversationPresenter: ConversationPresenterViewInterface {
    func goBackToListOfMessages() {
        return self.router.goToListOfMessageView()
    }
    
    func getChatMessages(){
        self.interactor.fetchMessages(chatUID: self.chat.id) { (result) in
            switch (result) {
            case .success(let fetchedDict):
                var fetchedMessages: [FirebaseMessage] = []
                for message in fetchedDict {
                    let messageDict = message.value as! [String: String]
                    if (message.key as! String).prefix(1) == "-" {
                        continue
                    }
                    fetchedMessages.append(FirebaseMessage(id: message.key as! String,
                                                           areCurrentUserIsAuthor: messageDict["Author"] != self.chat.reciver.id,
                                                           value: messageDict["Value"]))
                }
                self.viewModel.messagesToShow = fetchedMessages
                
            case .failure(_):
                print("Fetch Error")
            }
        }
    }
    
    func sendMessage(value: String){
        return self.interactor.sendMessage(chatUID: chat.id, value: value)
    }
}

extension ConversationPresenter: ConversationPresenterInteractorInterface {
    
}

extension ConversationPresenter: ConversationPresenterRouterInterface {
    
}
