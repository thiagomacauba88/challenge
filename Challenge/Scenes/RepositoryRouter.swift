//
//  SignInRouter.swift
//  Bway
//
//  Created by Thiago on 15/10/19.
//  Copyright © 2019 Bway. All rights reserved.
//

import UIKit

enum RepositoryEvent {
    case repositoryInit
}

class RepositoryRouter {
    
    // MARK: - Segue
    enum RepositorySegue {
        case repository
    }
    
    //MARK: - Properties
    private static let storyboardName = "Main"
    private let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    
    // MARK: - Actions
    func react(to event: RepositoryEvent, from source: UIViewController, info: Any?) {
        switch event {
        case .repositoryInit:
                self.showRepository(from: source, info: info)
            }
    }
    
    private func showRepository(from source: UIViewController, info: Any?) {
        let repositoryViewController = RepositoryViewController.instantiate(fromStoryboard: storyboard)
        perform(.repository, from: source, to: repositoryViewController)
    }
}

// MARK: - Navigation
private extension RepositoryRouter {
    
    func perform(_ segue: RepositorySegue, from source: UIViewController, to controller: UIViewController) {
        source.navigationController?.pushViewController(controller, animated: false)
    }
}

