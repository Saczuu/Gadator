//
//  HomeModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

//MARK: - Router
protocol HomeRouterPresenterInterface: RouterPresenterInterface {
    
    func goToRegisterView()
    func goToListOfMessageView()
    
}

//MARK: - Presenter
protocol  HomePresenterViewInterface: PresenterViewInterface {
    
    func hideErrorPopUp()
    func goToRegisterView()
    func logInUser(email: String, password: String)
    
}

protocol HomePresenterRouterInterface: PresenterRouterInterface {
}

protocol HomePresenterInteractorInterface: PresenterInteractorInterface {
    
}

//MARK: - Interactor
protocol HomeInteractorPresenterInteface: InteractorPresenterInterface {
    
    func LogIn(username: String, password: String, response: @escaping (Result<FirebaseUser,Error>) -> Void)
    
}

final class HomeModule: ModuleInterface {
    
    typealias View = HomeView
    typealias Presenter = HomePresenter
    typealias Router = HomeRouter
    typealias Interactor = HomeInteractor
    
    func build(coordinator: Coordinator) -> HomeView {
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        let viewModel = HomeViewModel()
        
        presenter.viewModel = viewModel
        presenter.interactor = interactor
        presenter.router = router
        router.coordinator = coordinator
        
        self.assemble(presenter: presenter, router: router, interactor: interactor)
        router.coordinator = coordinator
        let view = View(viewModel: viewModel, presenter: presenter)
        return view
    }
    
}
