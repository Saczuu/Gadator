//
//  HomePresenter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI

class HomePresenter: PresenterInterface {
    
    var viewModel: HomeViewModel!
    var interactor: HomeInteractor!
    var router: HomeRouter!
    
}

extension HomePresenter: HomePresenterViewInterface {
    func hideErrorPopUp() {
        viewModel.showErrorPopUp.toggle()
        viewModel.showLoadingIndicator.toggle()
    }
    
    func goToRegisterView() {
        router.goToRegisterView()
    }
    
    func logInUser(email: String, password: String) {
        viewModel.showLoadingIndicator.toggle()
        interactor.LogIn(username: email, password: password) { (result) in
            switch (result) {
            case .success(_) :
                self.viewModel.showLoadingIndicator.toggle()
                self.router.goToListOfMessageView()
            case .failure(let error) :
                self.viewModel.errorDiscription = error.localizedDescription
                self.viewModel.showErrorPopUp.toggle()
            }
        }
    }
}

extension HomePresenter: HomePresenterRouterInterface {
    
}

extension HomePresenter: HomePresenterInteractorInterface {
    
}
