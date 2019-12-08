//
//  HomePresenter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI

class HomePresenter {
    
    var viewModel: HomeViewModel!
    var interactor: HomeInteractor!
    var router: HomeRouter!
    
}
extension HomePresenter {
    
    
    func hideErrorPopUp() {
        self.viewModel.showErrorPopUp.toggle()
        self.viewModel.showLoadingIndicator.toggle()
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
    
    func goToRegisterView() {
        self.router.goToRegisterView()
    }
    
}
