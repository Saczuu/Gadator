//
//  RegisterModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: - Router
protocol RegisterRouterPresenterInterface: RouterPresenterInterface {
    func goToLoginView()
}
//MARK: - Presenter
protocol RegisterPresenterViewInterface: PresenterViewInterface {
    func signUp(name: String, email: String, password: String)
    func hideErrorPopUp()
    func hideSuccessPopUp()
    func goToLoginView()
}

protocol RegisterPresenterRouterInterface: PresenterRouterInterface {
    
}

protocol RegisterPresenterInteractorInterface: PresenterInteractorInterface {
    
}

//MARK: - Interactor
protocol RegisterInteractorPresenterInterface: InteractorPresenterInterface {
    func register(name: String, email: String, password: String, response: @escaping (Result<FirebaseUser,Error>) -> Void)
}


final class RegisterModule: ModuleInterface {
    typealias View = RegisterView
    
    typealias Presenter = RegisterPresenter
    
    typealias Router = RegisterRouter
    
    typealias Interactor = RegisterInteractor
    
    func build(coordinator: Coordinator) -> RegisterView {
        let presenter = Presenter()
        let interactor = Interactor()
        let router = Router()
        let viewModel = RegisterViewModel()
        
        presenter.viewModel = viewModel
        router.coordinator = coordinator
        self.assemble(presenter: presenter, router: router, interactor: interactor)
        let view = RegisterView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
