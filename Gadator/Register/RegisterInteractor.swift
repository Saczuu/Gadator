//
//  RegisterInteractor.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class RegisterInteractor {
    var presenter: RegisterPresenter!
    
    func register(name: String, email: String, password: String, response: @escaping (Result<FirebaseUser,Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let _ = authResult?.user, error == nil else {
                return response(.failure(error!))
            }
            let ref  = Database.database().reference()
            ref.child("Users").child(Auth.auth().currentUser!.uid).setValue(["Name": name])
            // To dismiss if registered succesfull
            return response(.success(FirebaseUser(id: "1", name: name)))
        }
    }
}
