//
//  RepositoryServices.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit

class RepositoryServices {

    // MARK: - Get Url Strings
    func getBaseUrl() -> String {
        return URLInfo.url(fromKey: "baseUrl")
    }
    
    ///search/repositories?q=language:swift&sort=stars&page={page}&per_page={perPage}
    func getRepositoriesUrl(page: String, perPage: String) -> String {
        var url = URLInfo.url(fromKey: "repositories")
        url = url.replacingOccurrences(of: "{page}", with: page)
        url = url.replacingOccurrences(of: "{perPage}", with: perPage)
        return self.getBaseUrl()+url
    }
    
    // MARK: - Services
    func repositories(page: String, perPage: String, success: @escaping ((_ sucessObject : RepositoryResponse?, _ serviceResponse: ServiceResponse?) -> Void), onFailure failure:((ServiceResponse?) -> Void)? = nil, onCompletion completion:(() -> Void)? = nil) {
        if let url = URL(string: getRepositoriesUrl(page: page, perPage: perPage)) {
            Service.shared.request(httpMethod: .get, url: url, payload: nil, auth: true).response(succeed: { (_ manutencao: RepositoryResponse?, _ serviceResponse: ServiceResponse?) in
                    if let response = manutencao, let content = serviceResponse {
                        success(response, content)
                    }
            }, failed: { (errorResponse) in
                failure?(errorResponse)
            }, completed: {
                completion?()
            })
        }
    }
    
}
