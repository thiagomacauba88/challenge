//
//  ApplicationRouter.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit
class ApplicationRouter {

    // MARK: - Enum
    enum ApplicationStartPoint {
        case initial
    }
    
    // MARK: - Properties
    fileprivate lazy var mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - Lifecycle
    func startApplication(in window: UIWindow?) {
        guard let window = window else { return }
        self.startApplication(in: window, startPoint: .initial)
    }
    
    func startApplication(in window: UIWindow, startPoint: ApplicationStartPoint) {
        switch startPoint {
        case .initial:
            let viewController = SplashViewController.instantiate(fromStoryboard: mainStoryboard)
            let rootNavigationController = UINavigationController(rootViewController: viewController)
            setRootNavigationController(rootNavigationController, for: window)
        }
    }
    
    fileprivate func setRootNavigationController(_ rootNavigationController: UINavigationController, for window: UIWindow) {
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
    }
}
