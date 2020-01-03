//
//  ListOfMessageModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/4/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

//MARK: - Router
protocol ListOfMessageRouterPresenterInterface: RouterPresenterInterface {
    func goToChatView(chat: FirebaseChat)
    func goToNewConversationView(userList: [FirebaseUser])
}
//MARK: - Presenter
protocol ListOfMessagePresenterViewInterface: PresenterViewInterface {
    func goToChatView(with chat: FirebaseChat)
    func goToNewConversation()
    func loadListOfMessage()
}
protocol ListOfMessagePresenterRouterInterface: PresenterRouterInterface {
    
}
protocol ListOfMessagePresenterInteractorInterface: PresenterInteractorInterface {
    
}
//MARK: - Interactor
protocol ListOfMessageInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchListOfMessage(response: @escaping (Result<NSDictionary,FetchError>) -> Void)
    func getCurrentUser() -> FirebaseAuth.User
    func fetchUsers(completion: @escaping (_ users: [FirebaseUser]?) -> ())
}

final class ListOfMessageModule: ModuleInterface {
    
    typealias View = ListOfMessageView
    
    typealias Presenter = ListOfMessagePresenter
    
    typealias Router = ListOfMessageRouter
    
    typealias Interactor = ListOfMessageInteractor
    
    func build(coordinator: Coordinator) -> ListOfMessageView {
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        let viewModel = ListOfMessageViewModel()
        
        presenter.viewModel = viewModel
        self.assemble(presenter: presenter, router: router, interactor: interactor)
        router.coordinator = coordinator
        
        let view = ListOfMessageView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
