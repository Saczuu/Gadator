//
//  ListOfMessagePresenter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/4/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI

class ListOfMessagePresenter {
    var viewModel: ListOfMessageViewModel!
    var interactor: ListOfMessageInteractor!
    var router: ListOfMessageRouter!
    
    var users: [FirebaseUser] = []
    
    private func getUser(with key: String) -> FirebaseUser? {
        for user in users {
            if user.id == key || user.name == key {
                return user
            }
        }
        return nil
    }
    
    func goToChatView(with chat: FirebaseChat) {
        return self.router.goToChatView(chat: chat)
    }
    
    func goToNewConversation() {
        return self.router.goToNewConversationView(userList: self.users)
    }
    
    func loadListOfMessage() {
        self.interactor.fetchListOfMessage { (result) in
            switch result {
            case .failure(_) :
                self.viewModel.showLoadingIndicator.toggle()
            case .success(let messageDict) :
                self.interactor.fetchUsers { (users) in
                    if users == nil {
                        return
                    } else {
                        self.users = users!
                        var fetchedAndFiltredChats: [FirebaseChat] = []
                        for chat in messageDict {
                            let chatContent = chat.value as! [String:AnyObject]
                            let chatMembers = chatContent["Members"] as! [String]
                            let chatMessages =  chatContent["Messages"] as! [String:[String:String]]
                            if chatMembers.contains(self.interactor.getCurrentUser().uid) {
                                // Create array of Message object
                                var messages: [FirebaseMessage] = []
                                for (uid, chatMessage) in chatMessages {
                                    if uid.prefix(1) == "-" {
                                        continue
                                    }
                                    messages.append(FirebaseMessage(id: uid,
                                                                    areCurrentUserIsAuthor: self.interactor.getCurrentUser().uid == chatMessage["Author"]!,
                                                                    value: chatMessage["Value"]!))
                                }
                                // Create array of User object
                                var reciver: FirebaseUser!
                                for chatMemberUID in chatMembers {
                                    if self.interactor.getCurrentUser().uid != chatMemberUID {
                                        reciver = self.getUser(with: chatMemberUID)
                                    }
                                }
                                // After create Chat object append it to userData
                                let chat = FirebaseChat(id: chat.key as! String,
                                                        reciver: reciver,
                                                        messages: messages)
                                fetchedAndFiltredChats.append(chat)
                            }
                        }
                        self.viewModel.messagesToShow = fetchedAndFiltredChats
                        self.viewModel.showLoadingIndicator = false
                    }
                }
            }
        }
    }
}
