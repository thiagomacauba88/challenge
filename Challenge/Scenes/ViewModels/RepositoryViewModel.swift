//
//  RepositoryViewModel.swift
//  Challenge
//
//  Created by Thiago on 17/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit
import RxSwift

class RepositoryViewModel {

    // MARK: - Properties
    let service = RepositoryServices()
    var repositoryResponse: RepositoryResponse?
    
    // MARK: - MISC
    func repositories(page: String, perPage: String) -> Observable<RepositoryResponse?> {
        return Observable.create { observable in
            self.service.repositories(page: page, perPage: perPage, success: { (challengeResponse, serviceResponse) in
                if let response = challengeResponse {
                    if self.repositoryResponse == nil {
                        self.repositoryResponse = response
                    } else {
                        self.repositoryResponse?.items?.append(contentsOf: response.items ?? [])
                    }
                    observable.onNext(self.repositoryResponse)
                }
                }, onFailure: { (serviceResponse) in
                if let error = serviceResponse?.serviceError {
                    observable.onError(error)
                }
            }, onCompletion: {
                observable.onCompleted()
            })
            return Disposables.create()
        }
    }
    
}
