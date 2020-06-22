//
//  RepositoryItensResponse.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

class RepositoryItensResponse: Codable {

    var name: String?
    var owner: OwnerResponse?
    var stargazers_count: Int32?
}
