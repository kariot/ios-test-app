//
//  BaseViewController.swift
//  Test App
//
//  Created by Matajar on 15/09/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavBar()
    }
    private func initNavBar() {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        self.navigationController?.navigationBar.topItem?.title = "";
    }
}
