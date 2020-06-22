//
//  ChallengeUITests.swift
//  ChallengeUITests
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import XCTest
import Nimble

class ChallengeUITests: XCTestCase {

    // MARK: - Properties
    let app = XCUIApplication()
    
    // MARK: - TESTS
    func testLaunch() {
        self.app.activate()
        self.app.launch()
    }
    
}
