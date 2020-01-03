//
//  HomeInteractor.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class HomeInteractor: InteractorInterface {
    
    typealias PresenterInteractor = HomePresenterInteractorInterface
    var presenter: PresenterInteractor!
    
}

//MARK: - Presenter
extension HomeInteractor: HomeInteractorPresenterInteface {
    func LogIn(username: String, password: String, response: @escaping (Result<FirebaseUser,Error>) -> Void) {
        Auth.auth().signIn(withEmail: username, password: password) { [self] authResult, error in
            guard error == nil else {
                return response(.failure(error!))
            }
            response(.success(FirebaseUser(id: "1", name: "User")))
        }
    }
}
