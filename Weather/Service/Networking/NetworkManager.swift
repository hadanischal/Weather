//
//  NetworkManager.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Alamofire

typealias AlamofireJSONCompletionHandler = (Result<Any>)->()

protocol Networking {
    func request(method: NetworkMethod, url: URL, parameters: [String : Any]?, completionHandler:@escaping AlamofireJSONCompletionHandler)
}

final class NetworkManager: Networking {
    func request(method: NetworkMethod, url: URL, parameters: [String : Any]?, completionHandler:@escaping AlamofireJSONCompletionHandler){
        print(url)
        print(parameters)
        let method = method.httpMethod()
        Alamofire.request(url, method: method, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(Result.success(value))
                case .failure(let error):
                    completionHandler(Result.failure(error))
                }
        }
    }
}


