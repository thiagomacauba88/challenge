//
//  RepositoryResponse.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

class RepositoryResponse: Codable {

    var total_count: Int?
    var items: [RepositoryItensResponse]?
}
