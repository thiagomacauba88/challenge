//
//  CALayerExtension.swift
//  Challenge
//
//  Created by Thiago on 17/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

extension CALayer {

    // Mark: - MISC
    func maskToCircle() {
        self.frame = self.frame.insetBy(dx: 0, dy: 0)
        self.cornerRadius = self.frame.height/2
        self.masksToBounds = true
    }
    
    func maskTo(_ corner: CGFloat) {
        self.cornerRadius = corner
        self.masksToBounds = true
    }
}
