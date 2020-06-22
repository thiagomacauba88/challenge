//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import XCTest
import Nimble
@testable import Challenge

class ChallengeTests: XCTestCase {

    var sut: URLSession!
    
    func testServiceIsUp() {
        sut = URLSession(configuration: .default)
        let url = URL(string: URLInfo.url(fromKey: "baseUrl"))
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = sut.dataTask(with: url!) { data, response, error in
          statusCode = (response as? HTTPURLResponse)?.statusCode
          responseError = error
          promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    // XCTest
    func testColorIsPurple() {
        let expectedColor = UIColor.init(from: "7B4CFE")
        XCTAssertEqual(UIColor.colorPurple, expectedColor)
    }
    
    // Nimble
    func testColorIsPurpleN() {
        let expectedColor = UIColor.init(from: "7B4CFE")
        expect(expectedColor).to(equal(UIColor.colorPurple))
    }
}
