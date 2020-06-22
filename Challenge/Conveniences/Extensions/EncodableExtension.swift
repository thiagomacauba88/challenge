//
//  EncodableExtension.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

extension Encodable {
    
    var dictionaryValue: Dictionary<String, Any>? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return jsonDictionary as? [String: Any]
        } catch {
            return nil
        }
    }
    
    var listValues: Data? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            return nil
        }
        return data
    }
    
}
