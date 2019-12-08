//
//  ListOfMessageModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/4/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI


final class ListOfMessageModule {
    func build(coordinator: Coordinator) -> ListOfMessageView {
        let presenter = ListOfMessagePresenter()
        let interactor = ListOfMessageInteractor()
        let router = ListOfMessageRouter()
        let viewModel = ListOfMessageViewModel()
        
        presenter.viewModel = viewModel
        presenter.interactor = interactor
        presenter.router = router
        router.coordinator = coordinator
        
        let view = ListOfMessageView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
