//
//  CleanViewController.swift
//  architectures
//
//  Created by Gerard on 02/07/2019.
//  Copyright © 2019 HS Lee. All rights reserved.
//

import Foundation
import UIKit

final class CleanViewController: UIViewController {

    // MARK: - * properties --------------------


    // MARK: - * IBOutlets --------------------


    // MARK: - * Initialize --------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initUI()
    }


    private func initProperties() {

    }

    private func initUI() {
        self.title = UIArchitectures.clean.title
    }

    func prepareViewDidLoad() {

    }

    // MARK: - * Main Logic --------------------


    // MARK: - * UI Events --------------------


    // MARK: - * Memory Manage --------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension CleanViewController {

}
