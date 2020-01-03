//
//  RegisterPresenter.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI

class RegisterPresenter: PresenterInterface {
    var viewModel: RegisterViewModel!
    var interactor: RegisterInteractorPresenterInterface!
    var router: RegisterRouterPresenterInterface!
}
extension RegisterPresenter: RegisterPresenterViewInterface {
    func signUp(name: String, email: String, password: String) {
        print("Start")
        self.viewModel.showLoadingIndicator.toggle()
        self.interactor.register(name: name, email: email, password: password) { (result) in
            switch result {
            case .success(_) :
                print("Succes")
                self.viewModel.showSuccessPopUp.toggle()
            case .failure(let error) :
                self.viewModel.errorDiscription = error.localizedDescription
                self.viewModel.showErrorPopUp.toggle()
            }
        }
    }
    
    func hideErrorPopUp() {
        self.viewModel.showErrorPopUp.toggle()
        self.viewModel.showLoadingIndicator.toggle()
    }
    
    func hideSuccessPopUp() {
        return goToLoginView()
    }
    
    func goToLoginView(){
        self.router.goToLoginView()
    }
}

extension RegisterPresenter: RegisterPresenterInteractorInterface {
    
}

extension RegisterPresenter: RegisterPresenterRouterInterface {
    
}
