//
//  Coordinator.swift
//  SwiftUI_Coordinator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 Maciej Sączewski. All rights reserved.
//

import SwiftUI

struct Coordinator: View {
    
    enum CurrentView {
        case login, register, listOfMessage, conversation, newConversation
    }
    
    @State var currentView: CurrentView = .login
    @State var chatToShow: FirebaseChat?
    @State var userList: [FirebaseUser]?
    
    var body: some View {
        switch currentView {
        case .login :
            return AnyView(HomeModule().build(coordinator: self)).transition(.slide)
        case .register :
            return AnyView(RegisterModule().build(coordinator: self)).transition(.slide)
        case .listOfMessage :
            return AnyView(ListOfMessageModule().build(coordinator: self)).transition(.slide)
        case .conversation :
            return AnyView(ConversationModule().build(chat: chatToShow!, coordinator: self)).transition(.slide)
        case .newConversation :
            return AnyView(NewConversationModule().build(userList: self.userList!, coordinator: self)).transition(.slide)
        }
    }
    
    func switchToListOfMessageView() {
        currentView = CurrentView.listOfMessage
    }
    
    func switchToNewConversationView(userList: [FirebaseUser]) {
        self.userList = userList
        currentView = CurrentView.newConversation
    }
    
    func switchToConversationView(with chat: FirebaseChat) {
        self.chatToShow = chat
        print(chat)
        currentView = CurrentView.conversation
    }
    
    func switchToRegisterView() {
        currentView = CurrentView.register
    }
    
    func switchToLoginView() {
        currentView = CurrentView.login
    }
}

struct Coordinator_Previews: PreviewProvider {
    static var previews: some View {
        Coordinator()
    }
}

