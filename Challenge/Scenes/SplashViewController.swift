//
//  SplashViewController.swift
//  Challenge
//
//  Created by Thiago on 20/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var verticalCenterImageViewConstraint: NSLayoutConstraint!
    @IBOutlet var customView: UIView!
    @IBOutlet var bottomCustomViewConstraint: NSLayoutConstraint!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var widthImageViewConstraint: NSLayoutConstraint!
    @IBOutlet var heightImageViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    let router = RepositoryRouter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    // MARK: - MISC
    private func initViews() {
        self.fadeIn()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func fadeIn(withDuration duration: TimeInterval = 1.5) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: duration, animations: {
                self.verticalCenterImageViewConstraint.isActive = false
                self.heightImageViewConstraint.constant = 80
                self.widthImageViewConstraint.constant = 80
                let margins = self.view.layoutMarginsGuide
                self.imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: -18).isActive = true
                self.imageView.addConstraint(NSLayoutConstraint(item: self.imageView ?? UIImage(), attribute: .width, relatedBy: .equal , toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
                self.imageView.addConstraint(NSLayoutConstraint(item: self.imageView ?? UIImage(), attribute: .height, relatedBy: .equal , toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
                self.bottomCustomViewConstraint.constant = self.view.bounds.height - self.getToBarHeight()
                self.view.layoutIfNeeded()
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                self.router.react(to: .repositoryInit, from: self, info: nil)
            }
        }
    }

}

// MARK: - Instantiation
extension SplashViewController {
    static func instantiate(fromStoryboard storyboard: UIStoryboard) -> SplashViewController {
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! SplashViewController
    }
}
