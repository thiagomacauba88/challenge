//
//  UITableViewExtension.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

public extension UITableView {

    func animate(cell: UITableViewCell, indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: -cell.frame.height / 2)
        cell.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.1 * Double(indexPath.row),
            options: [.curveEaseIn],
            animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
        })
    }
}
