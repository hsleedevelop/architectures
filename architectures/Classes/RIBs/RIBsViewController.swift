//
//  RIBsViewController.swift
//  architectures
//
//  Created by Gerard on 02/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import UIKit
import RIBs

protocol RootRouting: ViewableRouting {
    func routeToFetchingNotifications()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootListener: class {
    
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    var listener: RootListener?
    
    weak var router: RootRouting?
    weak var listner: RootListener?
    
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didFetch() {
        
    }
}

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

protocol RootInteractable: Interactable, FetchingNotificationsListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let fetchingNotificationsBuilder: FetchingNotificationsBuildable
    private var fetchingNotifications: ViewableRouting?
    
    init(interactor: RootInteractable, viewController: RootViewControllable, fetchingNotificationsBuilder: FetchingNotificationsBuildable) {
        self.fetchingNotificationsBuilder = fetchingNotificationsBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        routeToFetchingNotifications()
    }
    
    //private func routeToFetchingNotifications() {
    func routeToFetchingNotifications() {
        let fetchingNotifications = fetchingNotificationsBuilder.build(withListener: interactor)
        self.fetchingNotifications = fetchingNotifications
        attachChild(fetchingNotifications)
        viewController.present(viewController: fetchingNotifications.viewControllable)
    }
}

protocol RootDependency: Dependency {
    
}

final class RootComponent: Component<RootDependency> {
    
}

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

protocol RootDependencyFetchingNotifications: Dependency {
    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the LoggedOut scope.
}

extension RootComponent: FetchingNotificationsDependency {
    // TODO: Implement properties to provide for LoggedOut scope.
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RIBsViewController()
        let interactor = RootInteractor(presenter: viewController)
        
        let fetchingNotificationsBuilder = FetchingNotificationsBuilder(dependency: component)
        
        return RootRouter(interactor: interactor, viewController: viewController, fetchingNotificationsBuilder: fetchingNotificationsBuilder)
    }
}

class AppComponent: Component<EmptyDependency>, RootDependency {
    init() {
        super.init(dependency: EmptyComponent())
    }
}

final class RIBsViewController: UIViewController, RootPresentable, RootViewControllable {
    
    weak var listener: RootPresentableListener?
    
    func present(viewController: ViewControllable) {
        self.addChild(viewController.uiviewController)
        
        _ = viewController.uiviewController.view.then {
            self.view.addSubview($0)

            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        
        //present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func dismiss(viewController: ViewControllable) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }

    private func initUI() {
        self.title = UIArchitectures.ribS.title
    }
}
