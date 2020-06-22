//
//  BottomAlertViewController.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

class BottomAlertViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak private var textLabel: UILabel!
    
    // MARK: - Properties
    var text: String?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    // MARK: - UI Configuration
    func setupUI(){
        textLabel.text = text
    }
}

// MARK: - Instantiation
extension BottomAlertViewController {
    
    static func instantiateNew(withText text: String!) -> BottomAlertViewController {
        let storyboard = UIStoryboard(name: "Modals", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! BottomAlertViewController
        controller.text = text
        return controller
    }
}
