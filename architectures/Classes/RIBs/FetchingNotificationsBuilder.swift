//
//  FetchingNotificationsBuilder.swift
//  architectures
//
//  Created by HS Lee on 04/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import RIBs

protocol FetchingNotificationsDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FetchingNotificationsComponent: Component<FetchingNotificationsDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FetchingNotificationsBuildable: Buildable {
    func build(withListener listener: FetchingNotificationsListener) -> FetchingNotificationsRouting
}

final class FetchingNotificationsBuilder: Builder<FetchingNotificationsDependency>, FetchingNotificationsBuildable {

    override init(dependency: FetchingNotificationsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FetchingNotificationsListener) -> FetchingNotificationsRouting {
        _ = FetchingNotificationsComponent(dependency: dependency)
        let viewController = FetchingNotificationsViewController()
        let interactor = FetchingNotificationsInteractor(presenter: viewController)
        
        interactor.listener = listener
        return FetchingNotificationsRouter(interactor: interactor, viewController: viewController)
    }
}
