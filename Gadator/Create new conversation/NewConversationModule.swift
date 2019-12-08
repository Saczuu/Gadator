//
//  NewNewConversationModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/7/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Foundation
import Foundation
import SwiftUI


final class NewConversationModule {
    func build(userList: [FirebaseUser], coordinator: Coordinator) -> NewConversationView {
        let presenter = NewConversationPresenter()
        let interactor = NewConversationInteractor()
        let router = NewConversationRouter()
        let viewModel = NewConversationViewModel()
        
        viewModel.userList = userList
        presenter.viewModel = viewModel
        presenter.interactor = interactor
        presenter.router = router
        router.coordinator = coordinator
        
        let view = NewConversationView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
