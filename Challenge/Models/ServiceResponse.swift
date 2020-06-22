//
//  ServiceResponse.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//


import UIKit
import Foundation

struct ServiceResponse {
    
    // MARK: - Properties
    var data: Data?
    var rawResponse: String?
    var response: HTTPURLResponse?
    var request: URLRequest?
    var serviceError: ServiceError?
}
