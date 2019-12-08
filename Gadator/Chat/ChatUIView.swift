//
//  ChatUIView.swift
//  Gadator
//
//  Created by Maciej Sączewski on 11/13/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI
import Firebase

struct ChatUIView: View {
    
    @ObservedObject private var keyboard = KeyboardResponder()
    @EnvironmentObject var userData: UserData
    @State var newMessageText: String = ""
    @State var chat: Chat = Chat(firebaseID: "", members: [], messages: [])
    var chatUID: String
    var chatMembers: [User]
    
    var body: some View {
        VStack {
            List {
                ForEach(chat.messages) { message in
                    MessageRow(message: message, isCurrentUserAuthor: message.author.id == self.userData.user.id)
                }
            }.onAppear { UITableView.appearance().separatorStyle = .none }
            
            HStack {
                TextField("Your message", text: $newMessageText) {
                    self.sendMessage()
                }.textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    self.sendMessage()
                }) {
                    Image(systemName: "paperplane.fill").scaleEffect(1.3).foregroundColor(Color.blue)
                }.padding(.init(top: 0, leading: 0, bottom: 0, trailing: 16))
                
            }.padding(.bottom, self.keyboard.currentHeight)
                .padding([.leading, .trailing], 15)
        }.onAppear { self.fetchChat(chatUID: self.chatUID) }
            .navigationBarTitle(self.getReciver().name)
    }
    
    func getReciver() -> User {
        for user in chatMembers {
            if user.id != self.userData.user.id {
                return user
            }
        }
        return User(id: "nil", name: "nil")
    }
    
    func fetchChat(chatUID: String) {
        let ref: DatabaseReference = Database.database().reference()
        ref.child("Chats").child(chatUID).ref.observe(DataEventType.value, with: { (snapshot) in
            let chat = snapshot.value as! [String:AnyObject]
            let chatMembers = chat["Members"] as! [String]
            let chatMessages =  chat["Messages"] as! [String:[String:String]]
            if chatMembers.contains(self.userData.user.id) {
                // Current user is in member of chat
                // Create array of Message object
                var messages: [Message] = []
                for (key, chatMessage) in chatMessages {
                    if key == "nil" {
                        continue
                    }
                    messages.append(Message(author: self.getUser(uid: chatMessage["Author"]!), value: chatMessage["Value"]!))
                }
                // Create array of User object
                var members: [User] = []
                for chatMemberUID in chatMembers {
                    members.append(self.getUser(uid: chatMemberUID))
                }
                // After create Chat object append it to userData
                self.chat = Chat(firebaseID:chatUID, members: members, messages: messages.sorted(by: { (mess1, mess2) -> Bool in
                    mess1.id < mess2.id
                }))
            }
        })
    }
    
    func getUser(uid: String) -> User{
        for user in self.chatMembers {
            if user.id == uid {
                return user
            }
        }
        return User(id: "nil", name: "nil")
    }
    
    func sendMessage() {
        let ref  = Database.database().reference()
        ref.child("Chats").child(chatUID).child("Messages").child(getTodayString()).setValue(["Author":userData.user.id, "Value": newMessageText])
        self.newMessageText = ""
    }
    
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

struct ChatUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChatUIView(chatUID: "", chatMembers: [])
    }
}
