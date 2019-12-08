//
//  ConversationModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/6/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import Foundation
import SwiftUI


final class ConversationModule {
    func build(chat: FirebaseChat, coordinator: Coordinator) -> ConversationView {
        let presenter = ConversationPresenter()
        let interactor = ConversationInteractor()
        let router = ConversationRouter()
        let viewModel = ConversationViewModel()
        
        viewModel.messagesToShow = chat.messages
        viewModel.reciverName = chat.reciver.name
        presenter.viewModel = viewModel
        presenter.interactor = interactor
        presenter.router = router
        presenter.chat = chat
        router.coordinator = coordinator
        
        let view = ConversationView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
