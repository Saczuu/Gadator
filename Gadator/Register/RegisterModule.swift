//
//  RegisterModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/3/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI


final class RegisterModule {
    func build(coordinator: Coordinator) -> RegisterView {
        let presenter = RegisterPresenter()
        let interactor = RegisterInteractor()
        let router = RegisterRouter()
        let viewModel = RegisterViewModel()
        
        presenter.viewModel = viewModel
        presenter.interactor = interactor
        presenter.router = router
        router.coordinator = coordinator
        
        let view = RegisterView(viewModel: viewModel, presenter: presenter)
        return view
    }
}
