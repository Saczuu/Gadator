//
//  RegisterView.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    var presenter: RegisterPresenter!
    
    @State var userName: String = ""
    @State var userEmail: String = ""
    @State var userPassword: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Name", text: self.$userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                TextField("Email", text: self.$userEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                SecureField("Password", text: self.$userPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                Button(action: {
                    self.presenter.signUp(name: self.userName, email: self.userEmail, password: self.userPassword)
                }) {
                    Text("Create new user")
                        .padding()
                        .foregroundColor(.white)
                        .frame(minWidth:120, maxWidth: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .shadow(color: .gray, radius: 2, x: 5, y: 5)
                    )
                        .padding()
                }
            }
            
            if viewModel.showLoadingIndicator {
                VStack{
                    if viewModel.showSuccessPopUp {
                        VStack {
                            Spacer()
                            Text("Successfully creating new user")
                            Spacer()
                            Divider()
                            Button(action: {
                                self.presenter.hideSuccessPopUp()
                            }) {
                                Text("OK")
                            }
                        }
                        .padding()
                        
                    } else if viewModel.showErrorPopUp {
                        VStack {
                            Spacer()
                            Text(viewModel.errorDiscription)
                            Spacer()
                            Divider()
                            Button(action: {
                                self.presenter.hideErrorPopUp()
                            }) {
                                Text("OK")
                            }
                        }
                        .padding()
                        
                    } else {
                        HStack {
                            Image(systemName: "arrow.2.circlepath")
                                .rotationEffect(.degrees(viewModel.rotateIndicator ? 0 : -360))
                                .scaleEffect(2)
                                .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false).speed(0.3))
                                .onAppear {
                                    self.viewModel.rotateIndicator.toggle()
                            }
                            Text("Loading")
                                .padding()
                        }
                    }
                }
                .animation(.spring())
                .frame(minWidth:120, maxWidth: 380, minHeight: 50, maxHeight: viewModel.showErrorPopUp || viewModel.showSuccessPopUp ? 350 : 150)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 25, x: 0, y: 2)
                )
            }
        }
        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, minHeight: 0, idealHeight: .infinity, maxHeight: .infinity)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterModule().build(coordinator: Coordinator())
    }
}
