//
//  NewConversationInteractor.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Firebase

class NewConversationInteractor {
    var presenter: NewConversationPresenter!
    
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
//        ref.child("Chats").child(chatUID).child("Messages").child("-1").setValue(["Author": self.getCurrentUser().uid, "Value": "*staring conversation*"])
//        ref.child("Chats").child(chatUID).child("Members").setValue(["1": self.getCurrentUser().uid, "0": reciver.id])
        ref.child("Chats").child(chatUID).setValue(["Messages": ["-1": ["Author": self.getCurrentUser().uid, "Value": "*staring conversation*"]], "Members" : ["0": self.getCurrentUser().uid, "1": reciver.id]])
    }
    
}

