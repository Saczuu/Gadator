//
//  NewConversationView.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI

struct NewConversationView : View {
    
    @ObservedObject var viewModel: NewConversationViewModel
    var presenter: NewConversationPresenter!
    
    var body: some View {
        NavigationView {
            HStack {
                List (viewModel.userList) { user in
                    HStack {
                        Image(systemName: "plus.bubble")
                            .scaleEffect(1.5)
                        Text(user.name)
                    }
                    .onTapGesture {
                        self.presenter.selectReciver(reciver: user)
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Select reciver")
            .navigationBarItems(leading:
                Button(action: {
                    self.presenter.goBackToListOfMessage()
                }) {
                    HStack {
                        Image(systemName: "control")
                            .rotationEffect(.degrees(-90))
                        Text("Messages")
                    }
                }
            )
        }
    }
}

struct NewConversation_Previews: PreviewProvider {
    static var previews: some View {
        NewConversationModule().build(userList: [], coordinator: Coordinator())
    }
}
