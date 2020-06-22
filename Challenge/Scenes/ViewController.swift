//
//  ViewController.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryViewController: UIViewController {

    // MARK: - Properties
    let viewModel = RepositoryViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repositories(page:"1", perPage: "1")
    }
}

// MARK: - Services
extension RepositoryViewController {
    
    func repositories(page: String, perPage: String) {
        self.view.startLoading()
        self.viewModel.repositories(page: page, perPage: perPage)
            .observeOn(MainScheduler.instance).subscribe(onNext: { (response) in
                print("")
            }, onError: { (error) in
                //self.showAlertError(for: error)
            }, onCompleted: {
                self.view.stopLoading()
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
}

