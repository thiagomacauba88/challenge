//
//  ServiceError.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//


import Foundation

struct ServiceError: Codable, Error {
  
  // MARK: - Properties
  var code: String?
  var title: String?
  var detail: String?
  var statusCode: Int?
  var error: String?
  var message: String?
}
