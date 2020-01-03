//
//  NewNewConversationModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

//MARK: - Router
protocol NewConversationRouterPresenterInterface: RouterPresenterInterface {
    func goBackToListOfMessage()
    
    func goToChatView(chat: FirebaseChat)
}
//MARK: - Presenter
protocol NewConversationPresenterViewInterface: PresenterViewInterface {
    func goBackToListOfMessage()
    func selectReciver(reciver: FirebaseUser)
}
protocol NewConversationPresenterInteractorInterface: PresenterInteractorInterface {
    
}
protocol NewConversationPresenterRouterInterface: PresenterRouterInterface {
    
}
//MARK: - Interactor
protocol NewConversationInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchChat(with chatUID: String, response: @escaping (Result<NSDictionary,FetchError>) -> Void)
    func getCurrentUser() -> FirebaseAuth.User
    func createNewChat(with chatUID: String, reciver: FirebaseUser)
    func parseChat(chatDict: NSDictionary) -> FirebaseChat
    
}

final class NewConversationModule: ModuleInterface {
    typealias View = NewConversationView
    
    typealias Presenter = NewConversationPresenter
    
    typealias Router = NewConversationRouter
    
    typealias Interactor = NewConversationInteractor
    
    func build(userList: [FirebaseUser], coordinator: Coordinator) -> NewConversationView {
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        let viewModel = NewConversationViewModel()
        
        viewModel.userList = userList
        self.assemble(presenter: presenter, router: router, interactor: interactor)
        presenter.viewModel = viewModel
        router.coordinator = coordinator
        
        let view = NewConversationView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
