//
//  ConversationInteractor.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Firebase

class ConversationInteractor: InteractorInterface {
    var presenter: ConversationPresenterInteractorInterface!
    
    func getTodayString() -> String{
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        return today_string
    }
    
}
extension ConversationInteractor: ConversationInteractorPresenterInterface {
    
    func fetchMessages(chatUID: String, response: @escaping (Result<NSDictionary,FetchError>) -> Void) {
        let ref  = Database.database().reference()
        ref.child("Chats").child(chatUID).child("Messages").ref.observe(DataEventType.value, with: { (snapshot) in
            guard let fetchedMessages = snapshot.value as? NSDictionary else {
                return response(.failure(FetchError.unableToFetchChats))
            }
            return response(.success(fetchedMessages))
        })
    }
    
    func getCurrentUser() -> FirebaseAuth.User {
        return Auth.auth().currentUser!
    }
    
    func sendMessage(chatUID: String, value: String) {
        print(chatUID)
        let ref  = Database.database().reference()
        ref.child("Chats").child(chatUID).child("Messages").child(getTodayString()).setValue(["Author": self.getCurrentUser().uid, "Value": value])
    }
}
