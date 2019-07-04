//
//  ViewController.swift
//  architectures
//
//  Created by HS Lee on 02/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import Then

enum UIArchitectures: CaseIterable {
    case mvvm
    case mvvmC
    case ribS
    case clean
    
    var title: String {
        switch self {
        case .mvvm:
            return "MVVM"
        case .mvvmC:
            return "MVVM-C"
        case .ribS:
            return "RIBs"
        case .clean:
            return "Clean Architecture"
        }
    }
    
    var viewController: UIViewController.Type {
        switch self {
        case .mvvm:
            return MVVMViewController.self
        case .mvvmC:
            return MVVMCViewController.self
        case .ribS:
            return RIBsViewController.self
        case .clean:
            return CleanViewController.self
        }
    }
    
    func present(_ nc: UINavigationController?) {
        switch self {
        case .mvvm:
            let vc = self.viewController.init()
            nc?.pushViewController(vc, animated: true)
        case .mvvmC:
            let coordinator = MVVMCoordianator(navigationController: nc!)
            Facade.shared.coorinator = coordinator
            _ = coordinator.start().subscribe()
        case .ribS:
            
            let launchRouter = RootBuilder(dependency: AppComponent()).build()
//            launchRouter.launchFromWindow(nc?.view.window ?? UIWindow())
            Facade.shared.launchRouter = launchRouter
            nc?.pushViewController(launchRouter.viewControllable.uiviewController, animated: true)

            launchRouter.interactable.activate()
            launchRouter.load()
        case .clean:
            fallthrough
        default:
            let vc = self.viewController.init()
            nc?.pushViewController(vc, animated: true)
        }
    }
}

final class ViewController: UIViewController {

    // MARK: - * variables --------------------
    var disposeBag = DisposeBag()
    
    // MARK: - * UI Properties --------------------
    var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        bindData()
    }
    
    deinit {
        #if DEBUG
        print("\(NSStringFromClass(type(of: self))) deinit")
        #endif
    }
    
    private func initUI() {
        self.title = "UIArchitectures Lab"
        
        initTable()
    }
    
    private func initTable() {
        tableView = UITableView(frame: UIScreen.main.bounds).then {
            self.view.addSubview($0)
            
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
    
            $0.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            
            $0.estimatedRowHeight = 70
            $0.rowHeight = 70
        }
    }
    
    private func bindData() {
        
        Observable<[UIArchitectures]>.just(UIArchitectures.allCases)
            .bind(to: tableView.rx.items) { tv, index, element -> UITableViewCell in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "Cell") else { return .init() }
                cell.textLabel?.text = element.title
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(UIArchitectures.self)
            .subscribe(onNext: { [unowned self] in
                $0.present(self.navigationController)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] ip in
                self.tableView.deselectRow(at: ip, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
