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

    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.refreshControl = refreshControl
            self.tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Properties
    let viewModel = RepositoryViewModel()
    let disposeBag = DisposeBag()
    var page = 1
    var perPage = 20
    var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(RepositoryViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.clear
        return refreshControl
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.initServices()
    }
    
    // MARK: - MISC
    private func initViews() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.setNavigationImage()
        self.setStatusBar()
    }
    
    private func initServices() {
        self.repositories(page: self.page.description, perPage: self.perPage.description)
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.viewModel.repositoryResponse = nil
        self.page = 1
        self.repositories(page: self.page.description, perPage: self.perPage.description)
        self.refreshControl.endRefreshing()
    }
}

// MARK: - Instantiation
extension RepositoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repositoryResponse?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RepositoryTableViewCell, let item = self.viewModel.repositoryResponse?.items?[indexPath.row] {
            cell.setup(item: item)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let count = self.viewModel.repositoryResponse?.total_count {
            if let countList = self.viewModel.repositoryResponse?.items?.count {
                if countList > 0 {
                    if indexPath.row == countList - 1 {
                        if countList < count {
                            self.page += 1
                            self.repositories(page:self.page.description, perPage: self.perPage.description)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Services
extension RepositoryViewController {
    
    func repositories(page: String, perPage: String) {
        self.view.startLoading()
        self.viewModel.repositories(page: page, perPage: perPage)
            .observeOn(MainScheduler.instance).subscribe(onNext: { (response) in
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }, onError: { (error) in
                self.showAlertError(for: error)
            }, onDisposed: {
                self.view.stopLoading()
            }).disposed(by: disposeBag)
    }
}

// MARK: - Instantiation
extension RepositoryViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> RepositoryViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! RepositoryViewController
    }
}

