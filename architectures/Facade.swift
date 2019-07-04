//
//  Facade.swift
//  architectures
//
//  Created by Gerard on 03/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RIBs
    
final class Facade {
    static let shared = Facade()
    
    // MARK: - * properties --------------------
    var accessToken: BehaviorRelay<String> = .init(value: "")
    var globalDisposBag = DisposeBag()
 
    var launchRouter: LaunchRouting!
    
    var coorinator: BaseCoordinator<Void>!
    var observable: Observable<Any>!
    var disposable: Disposable!
    // MARK: - * Initialize --------------------

    // MARK: - * Main Logic --------------------
}

extension Facade {

}
