//
//  NewConversationPresenter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation


class NewConversationPresenter {
    var viewModel: NewConversationViewModel!
    var router: NewConversationRouter!
    var interactor: NewConversationInteractor!
    
    func goBackToListOfMessage() {
        return self.router.goBackToListOfMessage()
    }
    
    func selectReciver(reciver: FirebaseUser) {
        // Case one: in firebase is chat with id: currentUser_id+reciver_id, and we fetch this chat and push to ConversationView with it
        self.interactor.fetchChat(with: reciver.id + self.interactor.getCurrentUser().uid) { (result) in
            switch (result) {
            case .success(let chatDict) :
                var foundedChat = self.parseChat(chatDict: chatDict)
                foundedChat.reciver = reciver
                foundedChat.id = reciver.id + self.interactor.getCurrentUser().uid
                self.router.goToChatView(chat: foundedChat)
            case .failure(_) :
                print("Brak czatu")
            }
        }
        // Case two: in firebase is chat with id: reciver_id+currentUser_id, and we fetch this chat and push to ConversationView with it
        self.interactor.fetchChat(with: self.interactor.getCurrentUser().uid + reciver.id) { (result) in
            switch (result) {
            case .success(let chatDict) :
                var foundedChat = self.parseChat(chatDict: chatDict)
                foundedChat.reciver = reciver
                foundedChat.id = self.interactor.getCurrentUser().uid + reciver.id
                self.router.goToChatView(chat: foundedChat)
            case .failure(_) :
                print("Brak czatu")
            }
        }
        // Case three: there is no chat between currentUser and reciver, so we create new one with stadarized "starting message" and push it into ConversationView
        self.interactor.createNewChat(with: reciver.id + self.interactor.getCurrentUser().uid, reciver: reciver)
        self.interactor.fetchChat(with: reciver.id + self.interactor.getCurrentUser().uid) { (result) in
            switch (result) {
            case .success(let chatDict) :
                var foundedChat = self.parseChat(chatDict: chatDict)
                foundedChat.reciver = reciver
                foundedChat.id = reciver.id + self.interactor.getCurrentUser().uid
                self.router.goToChatView(chat: foundedChat)
            case .failure(_) :
                print("Brak czatu")
            }
        }
        
    }
    
    func parseChat(chatDict: NSDictionary) -> FirebaseChat{
        let chatMessages =  chatDict["Messages"] as! [String:[String:String]]
        var messages: [FirebaseMessage] = []
        for (uid, chatMessage) in chatMessages {
            if uid.prefix(1) == "-" {
                continue
            }
            messages.append(FirebaseMessage(id: uid,
                                            areCurrentUserIsAuthor: self.interactor.getCurrentUser().uid == chatMessage["Author"]!,
                                            value: chatMessage["Value"]!))
        }
        return FirebaseChat(id: "", reciver: FirebaseUser(id: "", name: ""), messages: messages)
    }
}
