//
//  UIViewControllerExtension.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

import Foundation
import UIKit

public extension UIViewController {
    

    func getToBarHeight()-> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height + (navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func setNavigationImage() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal , toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
         imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal , toItem: nil , attribute: .notAnAttribute, multiplier: 1.0, constant: 80))
        imageView.image = #imageLiteral(resourceName: "icLogo")
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    func setStatusBar() {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
             statusBar.backgroundColor = UIColor.colorPurple
             UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        } else {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.colorPurple
        }
    }
    
    
    // MARK: Alerts
    func showAlertError(for error: Error) {
        guard let serviceError = error as? ServiceError, let alertText = serviceError.message else { return }
        let bottomAlertController = BottomAlertViewController.instantiateNew(withText: alertText)
        self.present(bottomAlertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
