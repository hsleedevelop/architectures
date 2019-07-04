//
//  FetchingNotificationsViewController.swift
//  architectures
//
//  Created by HS Lee on 04/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol FetchingNotificationsPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func fetch()
}

final class FetchingNotificationsViewController: UIViewController, FetchingNotificationsPresentable, FetchingNotificationsViewControllable {

    weak var listener: FetchingNotificationsPresentableListener?
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildUI()
        listener?.fetch()
    }
    
    private func buildUI() {
        buildTable()
    }
    
    private func buildTable() {
        tableView = UITableView(frame: UIScreen.main.bounds).then {
            self.view.addSubview($0)
            
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
            
            $0.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailCell")
            $0.estimatedRowHeight = 70
            $0.rowHeight = 70
        }
    }
    
    // MARK: - * Main Logic --------------------
    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
}
