//
//  FetchingNotificationsInteractor.swift
//  architectures
//
//  Created by HS Lee on 04/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import RIBs
import RxSwift

protocol FetchingNotificationsRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol FetchingNotificationsPresentable: Presentable {
    var listener: FetchingNotificationsPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FetchingNotificationsListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func didFetch()
}

final class FetchingNotificationsInteractor: PresentableInteractor<FetchingNotificationsPresentable>, FetchingNotificationsInteractable, FetchingNotificationsPresentableListener {

    weak var router: FetchingNotificationsRouting?
    weak var listener: FetchingNotificationsListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: FetchingNotificationsPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func fetch() {
        listener?.didFetch()
    }
}

protocol NotificationsStream: class {
    var notifications: Observable<Notifications> { get }
}

protocol MutableNotificationsStream: NotificationsStream {
    func fetchNotifications()
}

class NotificationsStreamImpl: MutableNotificationsStream {
    
    func fetchNotifications() {
        
    }
    
    var notifications: Observable<Notifications> {
        return Observable.just([])
    }

}
