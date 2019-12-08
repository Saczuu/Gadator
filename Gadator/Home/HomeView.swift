//
//  HomeView.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    private var presenter: HomePresenter!
    
    @State var userEmail: String = ""
    @State var userPassword: String = ""
    
    init(presenter: HomePresenter, viewModel: HomeViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Email", text: self.$userEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                SecureField("Password", text: self.$userPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .trailing])
                HStack {
                    Button(action: {
                        self.presenter!.logInUser(email: self.userEmail, password: self.userPassword)
                    }) {
                        Text("Login")
                            .padding()
                            .foregroundColor(.white)
                            .frame(minWidth:120, maxWidth: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                    .shadow(color: .gray, radius: 2, x: 5, y: 5)
                        )
                            .padding()
                    }
                    
                    Button(action: {
                        self.presenter.goToRegisterView()
                    }) {
                        Text("Register")
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
            }
            
            if viewModel.showLoadingIndicator {
                VStack{
                    if viewModel.showErrorPopUp {
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
                .frame(minWidth:120, maxWidth: 380, minHeight: 50, maxHeight: viewModel.showErrorPopUp ? 350 : 150)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Coordinator()
    }
}
