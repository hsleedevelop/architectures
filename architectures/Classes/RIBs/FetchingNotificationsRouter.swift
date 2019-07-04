//
//  FetchingNotificationsRouter.swift
//  architectures
//
//  Created by HS Lee on 04/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import RIBs

protocol FetchingNotificationsInteractable: Interactable {
    var router: FetchingNotificationsRouting? { get set }
    var listener: FetchingNotificationsListener? { get set }
}

protocol FetchingNotificationsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FetchingNotificationsRouter: ViewableRouter<FetchingNotificationsInteractable, FetchingNotificationsViewControllable>, FetchingNotificationsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FetchingNotificationsInteractable, viewController: FetchingNotificationsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
