//
//  ListOfMessageInteractor.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/4/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class ListOfMessageInteractor: InteractorInterface {
    var presenter: ListOfMessagePresenterInteractorInterface!
}
extension ListOfMessageInteractor: ListOfMessageInteractorPresenterInterface {
    func fetchListOfMessage(response: @escaping (Result<NSDictionary,FetchError>) -> Void) {
        let ref  = Database.database().reference()
        ref.child("Chats").ref.observe(DataEventType.value, with: { (snapshot) in
            guard let fetchedMessages = snapshot.value as? NSDictionary else {
                return response(.failure(FetchError.unableToFetchChats))
            }
            return response(.success(fetchedMessages))
        })
    }
    
    func getCurrentUser() -> FirebaseAuth.User {
        return Auth.auth().currentUser!
    }
    
    func fetchUsers(completion: @escaping (_ users: [FirebaseUser]?) -> ()) {
        let ref = Database.database().reference()
        ref.child("Users").observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            guard let users = snapshot.value  as? NSDictionary else {
                completion(nil)
                return
            }
            var usersArray: [FirebaseUser] = []
            for user in users {
                let value = user.value as! [String: String]
                usersArray.append(FirebaseUser(id: user.key as! String, name: value["Name"]!))
            }
            completion(usersArray)
        })
    }
}
