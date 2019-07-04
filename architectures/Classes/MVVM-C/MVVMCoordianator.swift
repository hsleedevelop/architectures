//
//  MVVMCoordianator.swift
//  architectures
//
//  Created by Gerard on 04/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import RxSwift
import SafariServices

final class MVVMCoordianator: BaseCoordinator<Void> {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() -> Observable<Void> {
        let viewModel = MVVMCViewModel()
        let viewController = MVVMCViewController()
        
        viewController.viewModel = viewModel
        
        viewModel.showNotification
            .debug()
            .subscribe(onNext: { [unowned self] in
                let safariViewController = SFSafariViewController(url: $0)
                self.navigationController.present(safariViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        self.navigationController.pushViewController(viewController, animated: true)
        return .never()
    }
    
    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
}

extension MVVMCoordianator {

}
