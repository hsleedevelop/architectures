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

final class MVVMViewModel: ViewModelType {
    // MARK: - * Main Logic --------------------
    func transform(input: Input) -> Output {
        
        
//        let signInResults = input.signIn
//            .flatMap { _ in
//                ServiceProvider.shared.github.signIn()
//                    .catchError { error in
//                        print(error)
//                        return .just(Viewer(login: "error", name: "error"))
//                    }
//        }
        
        let notifications = input.signIn
            .flatMap { _ in
                ServiceProvider.shared.github.notifications()
                    .catchError { error in
                        print(error)
                        return .just([])
                }
        }
        
        return Output.init(notifications: notifications.asDriverOnErrorJustComplete())
    }
    
    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
}

extension MVVMViewModel {
    struct Input {
        let signIn: Observable<String>
    }
    
    struct Output {
        //let signInResults: Driver<Viewer>
        let notifications: Driver<Notifications>
    }
}
