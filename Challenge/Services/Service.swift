//
//  Service.swift
//  Challenge
//
//  Created by Thiago on 16/06/20.
//  Copyright © 2020 Challenge. All rights reserved.
//

import UIKit
import Foundation

class Service {
    
    // MARK: - Properties
    static let shared = Service()
    
    // oAuth
    private var _token: String?
    var x_uid: String?
    var currentMutableToken: String?
    private let timeOut = 30.0
    
    var token: String?
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    var defaultHeaders: [String: String] = [
        "content-type": "application/json"
    ]
    
    // MARK: - Misc
    func request(httpMethod: HTTPMethod, url: URL, payload: Data? = nil, auth: Bool = true) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = defaultHeaders
        request.timeoutInterval = timeOut
        print("/* ------ Request ------ */")
        print(url)
        if let dict = payload {
            request.httpBody = dict
            if let JSONString = String(data: request.httpBody ?? Data(), encoding: String.Encoding.utf8)
            {
                print(JSONString)
            }
            print("/* ------------- */")
        }
        if auth {
            if let authToken = Session.shared.token {
                request.addValue(authToken, forHTTPHeaderField: "X-Auth-Token")
            }
        }
        return request
    }
    
    func request(httpMethod: HTTPMethod, url: URL, payload: [String: Any]? = nil,
                 headers: [String:String]? = nil, auth: Bool = true) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = defaultHeaders
        request.timeoutInterval = timeOut
        print("/* ------ Request ------ */")
        print(url)
        if let dict = payload {
            request.httpBody = Json.serialize(dictionary: dict)
            if let JSONString = String(data: request.httpBody ?? Data(), encoding: String.Encoding.utf8)
            {
                print(JSONString)
            }
            print("/* ------------- */")
        }
        if auth {
            if let authToken = Session.shared.token {
                request.addValue(authToken, forHTTPHeaderField: "X-Auth-Token")
            }
        }
        return request
    }
}

// MARK: - URLRequestExtension
// handle HTTPURLResponse and dispatch the request
extension URLRequest {
    
    private func setUnknowErrorFor(serviceResponse: inout ServiceResponse) {
        serviceResponse.serviceError = ServiceError(code: nil, title: "Error", detail: nil, statusCode: nil, error: "Unexpected.", message: "Error")
    }
    
    private func setTimeOutError(serviceResponse: inout ServiceResponse, error: Error) {
        serviceResponse.serviceError = ServiceError(code: nil, title: "Error", detail: nil, statusCode: nil, error: "TimeOut.", message: error.localizedDescription)
    }
    
    private func mapErrors(statusCode: Int, error: Error?, serviceResponse: inout ServiceResponse) {
        
        guard error == nil else {
            setUnknowErrorFor(serviceResponse: &serviceResponse)
            return
        }
        
        switch statusCode {
//        case 401:
//            serviceResponse.serviceError = ServiceError(code: nil, title: "Unauthorized", detail: nil, statusCode: statusCode, error: "Unauthorized", message: "Unauthorized")
//        case 403:
//            // Case 403, version update required
//            serviceResponse.serviceError = ServiceError(code: nil, title: "Update needed", detail: nil, statusCode: statusCode, error: "UpdateNeeded", message: "Update needed")
//        case 404:
//            serviceResponse.serviceError = ServiceError(code: nil, title: "Not Found", detail: nil, statusCode: statusCode, error: "NotFound", message: "Not Found")
        case 400...499:
            guard 400...499 ~= statusCode, let data = serviceResponse.data, let jsonString = String(data: data, encoding: .utf8),
                let serializedValue = try? JSONDecoder().decode(ServiceError.self, from: data) else {
                    setUnknowErrorFor(serviceResponse: &serviceResponse)
                    return
            }
            
            serviceResponse.rawResponse = jsonString
            
            if serializedValue.message == nil {
                setUnknowErrorFor(serviceResponse: &serviceResponse)
            } else {
                serviceResponse.serviceError = serializedValue
            }
        case 500...599:
            serviceResponse.serviceError = ServiceError(code: nil, title: "Server Error", detail: nil, statusCode: statusCode, error: "ServerError", message: "Server Error")
        default:
            setUnknowErrorFor(serviceResponse: &serviceResponse)
        }
    }
    
    // Dispatch URLRequest instance
    private func dispatch(onCompleted completion: @escaping (ServiceResponse) -> Void) {
        
        URLSession.shared.dataTask(with: self) { data, res, error in
            
            //self.handleOAuthCallback(res: res)
            
            var serviceResponse = ServiceResponse()
        
            
            serviceResponse.response = res as? HTTPURLResponse
            serviceResponse.request = self
            serviceResponse.data = data
            
            if let data = data {
                serviceResponse.rawResponse = String(data: data, encoding: .utf8)
            }
            
            guard let statusCode = serviceResponse.response?.statusCode else {
                self.setUnknowErrorFor(serviceResponse: &serviceResponse)
                completion(serviceResponse)
                return
            }
            
            if !(200...299 ~= statusCode) {
                self.mapErrors(statusCode: statusCode, error: error, serviceResponse: &serviceResponse)
            }
            
            completion(serviceResponse)
            
            }.resume()
    }
    /// Use this method when there is no need to serialize service payload
    func response(succeed success: @escaping (ServiceResponse) -> Void,
                  failed failure: @escaping (ServiceResponse) -> Void,
                  completed completion: @escaping () -> Void) {
        
        dispatch { (serviceResponse) in
            print("/* ------ Response  "+(serviceResponse.response?.statusCode.description ?? "")+" ------ */")
            if let JSONString = String(data: serviceResponse.data ?? Data(), encoding: String.Encoding.utf8)
            {
                print(JSONString)
            }
            print("/* ------------- */")
            if let _ = serviceResponse.serviceError {
                failure(serviceResponse)
            } else {
                success(serviceResponse)
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    /// Use this method to serialize object payload
    func response<SuccessObjectType: Codable>(succeed success: @escaping (SuccessObjectType?, ServiceResponse) -> Void,
                                              failed failure: @escaping (ServiceResponse) -> Void,
                                              completed completion: @escaping () -> Void) {
        
        
        dispatch { (serviceResponse) in
            print("/* ------ Response "+(serviceResponse.response?.statusCode.description ?? "")+" ------ */")
            if let JSONString = String(data: serviceResponse.data ?? Data(), encoding: String.Encoding.utf8)
            {
                print(JSONString)
            }
            print("/* ------------- */")
            if let _ = serviceResponse.serviceError {
                failure(serviceResponse)
            } else {
                if let data = serviceResponse.data {
                    do {
                        let serializedObject = try JSONDecoder().decode(SuccessObjectType.self, from: data)
                        success(serializedObject, serviceResponse)
                    } catch let parserError {
                        debugPrint("*** parserError ***")
                        debugPrint(parserError)
                        success(nil, serviceResponse)
                    }
                    
                } else {
                    success(nil, serviceResponse)
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    /// Use this method to serialize array payload
    func response<SuccessObjectType: Codable>(succeed success: @escaping ([SuccessObjectType]?, ServiceResponse) -> Void,
                                              failed failure: @escaping (ServiceResponse) -> Void,
                                              completed completion: @escaping () -> Void) {
        
        dispatch { (serviceResponse) in
            print("/* ------ Response  "+(serviceResponse.response?.statusCode.description ?? "")+" ------ */")
            if let JSONString = String(data: serviceResponse.data ?? Data(), encoding: String.Encoding.utf8)
            {
                print(JSONString)
            }
            print("/* ------------- */")
            if let _ = serviceResponse.serviceError {
                failure(serviceResponse)
            } else {
                if let data = serviceResponse.data {
                    do {
                        let serializedObject = try JSONDecoder().decode([SuccessObjectType].self, from: data)
                        success(serializedObject, serviceResponse)
                    } catch let parserError {
                        debugPrint("*** parserError ***")
                        debugPrint(parserError)
                        success(nil, serviceResponse)
                    }
                } else {
                    success(nil, serviceResponse)
                }
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
