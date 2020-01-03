//
//  ConversationModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Firebase
import SwiftUI

//MARK: - Router
protocol ConversationRouterPresenterInterface: RouterPresenterInterface {
    func goToListOfMessageView()
}
//MARK: - Presenter
protocol ConversationPresenterViewInterface: PresenterViewInterface {
    func goBackToListOfMessages()
    func getChatMessages()
    func sendMessage(value: String)
}
protocol ConversationPresenterRouterInterface: PresenterRouterInterface {
    
}
protocol ConversationPresenterInteractorInterface: PresenterInteractorInterface {
    
}
// MARK: - Interactor
protocol ConversationInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchMessages(chatUID: String, response: @escaping (Result<NSDictionary,FetchError>) -> Void)
    func getCurrentUser() -> FirebaseAuth.User
    func sendMessage(chatUID: String, value: String)
}

final class ConversationModule: ModuleInterface {
    
    typealias View = ConversationView
    
    typealias Presenter = ConversationPresenter
    
    typealias Router = ConversationRouter
    
    typealias Interactor = ConversationInteractor
    
    
    func build(chat: FirebaseChat, coordinator: Coordinator) -> ConversationView {
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        let viewModel = ConversationViewModel()
        
        viewModel.messagesToShow = chat.messages
        viewModel.reciverName = chat.reciver.name
        presenter.chat = chat
        presenter.viewModel = viewModel
        router.coordinator = coordinator
        self.assemble(presenter: presenter, router: router, interactor: interactor)
        
        let view = ConversationView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
