//
//  NewConversationPresenter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation


class NewConversationPresenter: PresenterInterface {
    var viewModel: NewConversationViewModel!
    var router: NewConversationRouterPresenterInterface!
    var interactor: NewConversationInteractorPresenterInterface!
}
extension NewConversationPresenter: NewConversationPresenterViewInterface {
    func goBackToListOfMessage() {
        return router.goBackToListOfMessage()
    }
    
    func selectReciver(reciver: FirebaseUser) {
        // Case one: in firebase is chat with id: currentUser_id+reciver_id, and we fetch this chat and push to ConversationView with it
        interactor.fetchChat(with: reciver.id + interactor.getCurrentUser().uid) { (result) in
            switch (result) {
            case .success(let chatDict) :
                var foundedChat = self.interactor.parseChat(chatDict: chatDict)
                foundedChat.reciver = reciver
                foundedChat.id = reciver.id + self.interactor.getCurrentUser().uid
                self.router.goToChatView(chat: foundedChat)
            case .failure(_) :
                print("Brak czatu")
            }
        }
        // Case two: in firebase is chat with id: reciver_id+currentUser_id, and we fetch this chat and push to ConversationView with it
        interactor.fetchChat(with: interactor.getCurrentUser().uid + reciver.id) { (result) in
            switch (result) {
            case .success(let chatDict) :
                var foundedChat = self.interactor.parseChat(chatDict: chatDict)
                foundedChat.reciver = reciver
                foundedChat.id = self.interactor.getCurrentUser().uid + reciver.id
                self.router.goToChatView(chat: foundedChat)
            case .failure(_) :
                print("Brak czatu")
            }
        }
        // Case three: there is no chat between currentUser and reciver, so we create new one with stadarized "starting message" and push it into ConversationView
        interactor.createNewChat(with: reciver.id + interactor.getCurrentUser().uid, reciver: reciver)
        interactor.fetchChat(with: reciver.id + interactor.getCurrentUser().uid) { (result) in
            switch (result) {
            case .success(let chatDict) :
                var foundedChat = self.interactor.parseChat(chatDict: chatDict)
                foundedChat.reciver = reciver
                foundedChat.id = reciver.id + self.interactor.getCurrentUser().uid
                self.router.goToChatView(chat: foundedChat)
            case .failure(_) :
                print("Brak czatu")
            }
        }
    }
}

extension NewConversationPresenter: NewConversationPresenterInteractorInterface {
    
}

extension NewConversationPresenter: NewConversationPresenterRouterInterface {
    
}
