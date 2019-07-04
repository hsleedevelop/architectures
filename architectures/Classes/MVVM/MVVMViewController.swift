//
//  MVVMViewController.swift
//  architectures
//
//  Created by Gerard on 02/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SafariServices

final class MVVMViewController: UIViewController {

    // MARK: - * properties --------------------
    var viewModel = MVVMViewModel()
    var disposeBag = DisposeBag()

    // MARK: - * IBOutlets --------------------
    var tableView: UITableView!

    // MARK: - * Initialize --------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        title = UIArchitectures.mvvmC.title
        
        setupTable()
    }
    
    private func setupTable() {
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

extension MVVMViewController {

    /// bindViewModel( - Description:
    private func setupBindings() {
        
        let output = viewModel.transform(input: MVVMViewModel.Input(signIn: .just("")))
        
//        output.signInResults
//            .debug(">>>", trimOutput: false)
//            .drive(onNext: {
//                print($0)
//            })
//            .disposed(by: disposeBag)
        
        output.notifications
            .debug(">", trimOutput: true)
            .drive(tableView.rx.items) { tv, index, element -> UITableViewCell in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailTableViewCell else {
                    return .init()
                }

                cell.titleLabel?.text = element.repository.name
                cell.detailLabel?.text = "> " + element.subject.title
                
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Notification.self)
            .subscribe(onNext: { [unowned self] in
                if let url = URL(string: $0.repository.htmlURL + "/releases"), UIApplication.shared.canOpenURL(url) {
                    let safariViewController = SFSafariViewController(url: url)
                    self.navigationController?.present(safariViewController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] ip in
                self.tableView.deselectRow(at: ip, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
