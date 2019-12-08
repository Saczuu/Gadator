import Foundation

// MARK: - VIPER
public protocol RouterInterface: RouterPresenterInterface {
    associatedtype PresenterRouter

    var presenter: PresenterRouter! { get set }
}

public protocol InteractorInterface: InteractorPresenterInterface {
    associatedtype PresenterInteractor
    
    var presenter: PresenterInteractor! { get set }
}

public protocol PresenterInterface: PresenterRouterInterface & PresenterInteractorInterface & PresenterViewInterface {
    associatedtype RouterPresenter
    associatedtype InteractorPresenter

    var router: RouterPresenter! { get set }
    var interactor: InteractorPresenter! { get set }
}

public protocol ViewInterface {
    associatedtype PresenterView
    
    var presenter: PresenterView! { get set }
}

public protocol EntityInterface {
    
}

// MARK: - "i/o" transitions
public protocol RouterPresenterInterface: class {
    
}

public protocol InteractorPresenterInterface: class {
    
}

public protocol PresenterRouterInterface: class {
    
}

public protocol PresenterInteractorInterface: class {
    
}

public protocol PresenterViewInterface: class {
    
}
// MARK: - module
public protocol ModuleInterface {

    associatedtype View
    associatedtype Presenter
    associatedtype Router
    associatedtype Interactor where Interactor: InteractorInterface
    
    func assemble(presenter: Presenter, router: Router, interactor: Interactor)
}

public extension ModuleInterface {

    func assemble(presenter: Presenter, router: Router, interactor: Interactor) {

        presenter.interactor = (interactor as! Self.Presenter.InteractorPresenter)
        presenter.router = (router as! Self.Presenter.RouterPresenter)
        
        interactor.presenter = (presenter as! Self.Interactor.PresenterInteractor)
        
        router.presenter = (presenter as! Self.Router.PresenterRouter)
    }
}
