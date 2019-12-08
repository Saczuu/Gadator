//
//  HomeModule.swift
//  Gadator
//
//  Created by Maciej Sączewski on 12/2/19.
//  Copyright © 2019 SCM. All rights reserved.
//

import Foundation
import SwiftUI


final class HomeModule {
    func build(coordinator: Coordinator) -> HomeView {
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let viewModel = HomeViewModel()
        
        presenter.viewModel = viewModel
        presenter.interactor = interactor
        presenter.router = router
        router.coordinator = coordinator
        
        let view = HomeView(presenter: presenter, viewModel: viewModel)
        return view
    }
}
