//
//  URLInfo.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

class URLInfo {
    
     static func url(fromKey key: String) -> String {
     guard let path = Bundle.main.path(forResource: "URLs", ofType: "plist"),
     let dict = NSDictionary(contentsOfFile: path) as? [String: String] else { return ""}
     
     if let url = dict[key] {
        return (url)
     } else {
        return ""
     }
    }
}
