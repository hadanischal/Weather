//
//  NetworkManager.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Alamofire

typealias AlamofireJSONCompletionHandler = (Result<Any>) -> Void
typealias responseDataJSONCompletionHandler = (Result<Data>) -> Void

protocol Networking {
    func request(method: NetworkMethod, url: URL, parameters: [String: Any]?, completionHandler:@escaping AlamofireJSONCompletionHandler)
    func responseData(method: NetworkMethod, url: URL, parameters: [String: Any]?, completionHandler:@escaping responseDataJSONCompletionHandler)
}

final class NetworkManager: Networking {
    func request(method: NetworkMethod, url: URL, parameters: [String: Any]?, completionHandler:@escaping AlamofireJSONCompletionHandler) {
        print(url)
        print(parameters ?? "nil")
        let method = method.httpMethod()
        Alamofire.request(url, method: method, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(response.result.value ?? "nil")
                    completionHandler(Result.success(value))
                case .failure(let error):
                    completionHandler(Result.failure(error))
                }
        }
    }

    func responseData(method: NetworkMethod, url: URL, parameters: [String: Any]?, completionHandler:@escaping responseDataJSONCompletionHandler) {
        print(url)
        print(parameters ?? "nil")
        let method = method.httpMethod()
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completionHandler(Result.success(data))
                    }
                    print(response.result.value ?? "nil")
                case .failure(let error):
                    completionHandler(Result.failure(error))
                }
            })
    }
}
