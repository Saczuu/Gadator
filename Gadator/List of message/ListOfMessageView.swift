//
//  ListOfMessageView.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/4/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI

struct ListOfMessageView: View, ViewInterface {
    
    @ObservedObject var viewModel: ListOfMessageViewModel
    var presenter: ListOfMessagePresenterViewInterface!
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if !viewModel.messagesToShow.isEmpty {
                        List(viewModel.messagesToShow) { chat in
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding([.leading, .trailing], 5.0)
                                VStack(alignment: .leading) {
                                    Text(chat.reciver.name)
                                    if !chat.messages.isEmpty {
                                        HStack {
                                            Text(chat.messages.sorted(by: { (message1, message2) -> Bool in
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd HH:m:s"
                                                return dateFormatter.date(from: message1.id)! < dateFormatter.date(from: message2.id)!
                                            }).last!.areCurrentUserIsAuthor ? "You:" : "\(chat.reciver.name):")
                                            Text(chat.messages.sorted(by: { (message1, message2) -> Bool in
                                                let dateFormatter = DateFormatter()
                                                dateFormatter.dateFormat = "yyyy-MM-dd HH:m:s"
                                                return dateFormatter.date(from: message1.id)! < dateFormatter.date(from: message2.id)!
                                            }).last!.value)
                                        }
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    }
                                }
                                Spacer()
                                Image(systemName: "control")
                                    .rotationEffect(.degrees(90))
                                    .foregroundColor(.gray)
                            }
                            .onTapGesture {
                                print(chat)
                                self.presenter.goToChatView(with: chat)
                            }
                            .frame(height:55)
                        }
                    }
                    else {
                        Text("You have no chats")
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .singleLine
                }
                .navigationBarTitle("Messages")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.presenter.goToNewConversation()
                    }) {
                        Image(systemName: "plus")
                })
            }
            if viewModel.showLoadingIndicator{
                HStack {
                    Image(systemName: "arrow.2.circlepath")
                        .rotationEffect(.degrees(self.viewModel.rotateIndicator ? 0 : -360))
                        .scaleEffect(2)
                        .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false).speed(0.3))
                        .onAppear {
                            self.viewModel.rotateIndicator.toggle()
                    }
                    Text("Loading")
                        .padding()
                }
                .frame(minWidth:120, maxWidth: 380, minHeight: 50, maxHeight: 150)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 25, x: 0, y: 2)
                )
            }
        }
        .onAppear {
            self.presenter.loadListOfMessage()
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity)
    }
}

struct ListOfMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfMessageModule().build(coordinator: Coordinator())
    }
}
