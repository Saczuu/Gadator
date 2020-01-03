//
//  NewConversationInteractor.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Firebase

class NewConversationInteractor: InteractorInterface {
    var presenter: NewConversationPresenterInteractorInterface!
}
extension NewConversationInteractor: NewConversationInteractorPresenterInterface {
    func getCurrentUser() -> FirebaseAuth.User {
        return Auth.auth().currentUser!
    }
    
    func fetchChat(with chatUID: String, response: @escaping (Result<NSDictionary,FetchError>) -> Void) {
        let ref  = Database.database().reference()
        ref.child("Chats").child(chatUID).ref.observe(DataEventType.value, with: { (snapshot) in
            guard let fetchedChat = snapshot.value as? NSDictionary else {
                    return response(.failure(FetchError.unableToFetchChats))
                }
                return response(.success(fetchedChat))
            })
    }
    
    func createNewChat(with chatUID: String, reciver: FirebaseUser) {
        let ref  = Database.database().reference()
        ref.child("Chats").child(chatUID).setValue(["Messages": ["-1": ["Author": self.getCurrentUser().uid, "Value": "*staring conversation*"]], "Members" : ["0": self.getCurrentUser().uid, "1": reciver.id]])
    }
    
    func parseChat(chatDict: NSDictionary) -> FirebaseChat{
        let chatMessages =  chatDict["Messages"] as! [String:[String:String]]
        var messages: [FirebaseMessage] = []
        for (uid, chatMessage) in chatMessages {
            if uid.prefix(1) == "-" {
                continue
            }
            messages.append(FirebaseMessage(id: uid,
                                            areCurrentUserIsAuthor: self.getCurrentUser().uid == chatMessage["Author"]!,
                                            value: chatMessage["Value"]!))
        }
        return FirebaseChat(id: "", reciver: FirebaseUser(id: "", name: ""), messages: messages)
    }
    
}

