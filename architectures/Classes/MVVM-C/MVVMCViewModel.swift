//
//  MVVMCViewModel.swift
//  architectures
//
//  Created by Gerard on 03/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxCocoaExt
import RxSwiftUtilities
import RxSwiftExt
import RxOptional

final class MVVMCViewModel {

    // MARK: - * properties --------------------
    let notifications: Observable<Notifications>
    
    let selectNotification: AnyObserver<Notification>
    let showNotification: Observable<URL>
    
    init() {
        
        notifications = Observable<Void>.just(())
            .flatMap { _ in
                ServiceProvider.shared.github.notifications()
                    .catchError { error in
                        print(error)
                        return .just([])
                }
        }
        
        let _fetchNotification = PublishSubject<Notification>()
        selectNotification = _fetchNotification.asObserver()
        showNotification = _fetchNotification.asObservable()
            .map { URL(string: $0.repository.htmlURL + "/releases") }
            .filterNil()
            .filter { UIApplication.shared.canOpenURL($0) }
    }
    
    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
}

extension MVVMCViewModel {

}
