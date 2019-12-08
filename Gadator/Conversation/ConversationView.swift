//
//  ConversationView.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI

struct ConversationView: View {
    
    @ObservedObject var viewModel: ConversationViewModel
    var presenter: ConversationPresenter!
    
    @State var newMessageText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.messagesToShow.sorted(by: { (message1, message2) -> Bool in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:m:s"
                    return dateFormatter.date(from: message1.id)! < dateFormatter.date(from: message2.id)!
                })) { message in
                    HStack {
                        if message.areCurrentUserIsAuthor {
                            Spacer()
                            Text("\(message.value)")
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.blue)
                            )
                        } else {
                            Text("\(message.value)")
                                .padding()
                                .foregroundColor(.black)
                                .background(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(Color.gray)
                            )
                            Spacer()
                        }
                    }
                }
                HStack {
                    TextField("Your message", text: $newMessageText) {
                        self.presenter.sendMessage(value: self.newMessageText)
                        self.newMessageText = ""
                    }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.presenter.sendMessage(value: self.newMessageText)
                        self.newMessageText = ""
                    }) {
                        Image(systemName: "paperplane.fill").scaleEffect(1.3).foregroundColor(Color.blue)
                    }.padding(.init(top: 0, leading: 0, bottom: 0, trailing: 16))
                }
            }
            .padding([.trailing, .leading], 10)
            .navigationBarTitle(viewModel.reciverName)
            .navigationBarItems(leading:
                Button(action: {
                    self.presenter.goBackToListOfMessages()
                }) {
                    HStack {
                        Image(systemName: "control")
                            .rotationEffect(.degrees(-90))
                        Text("Messages")
                    }
                }
            )
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                    self.presenter.getChatMessages()
            }
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationModule().build(chat: FirebaseChat(id: "",
                                                      reciver: FirebaseUser(id: "", name: ""),
                                                      messages: [FirebaseMessage(id: "", areCurrentUserIsAuthor: true, value: "text")]), coordinator: Coordinator())
    }
}
