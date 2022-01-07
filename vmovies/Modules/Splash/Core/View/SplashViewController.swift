//
//  SplashViewController.swift
//  vmovies
//
//  Created by Shady Abdelaziz on 1/6/22.
//

import UIKit

class SplashViewController: UIViewController {

    var presenter : SplashViewToPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}

// MARK:- SplashPresenterToView
extension SplashViewController: SplashPresenterToView {

}
