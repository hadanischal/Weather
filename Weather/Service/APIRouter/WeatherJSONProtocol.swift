//
//  WeatherJSONProtocol.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

typealias WeatherJSONCompletionHandler = (Result<[String : Any]>)->()
protocol WeatherJSONProtocol {
    static func handle(result: Result<Any>, completionHandler: WeatherJSONCompletionHandler)
    static func handleSuccessfulAPICall(for json: Any, completionHandler: WeatherJSONCompletionHandler)
    static func handleFailedAPICall(for error: Error, completionHandler: WeatherJSONCompletionHandler)
}

extension WeatherJSONProtocol {
    static func handle(result: Result<Any>, completionHandler: WeatherJSONCompletionHandler) {
        switch result {
        case .success(let json):
            self.handleSuccessfulAPICall(for: json, completionHandler: completionHandler)
        case .failure(let error):
            self.handleFailedAPICall(for: error, completionHandler: completionHandler)
        }
    }
    
    static func handleSuccessfulAPICall(for json: Any, completionHandler: WeatherJSONCompletionHandler) {
        guard let json = json as? [String : Any] else {
            let error = NetworkingError.badJSON
            handleFailedAPICall(for: error, completionHandler: completionHandler)
            return
        }
        completionHandler(Result.success(json))
    }
    
    static func handleFailedAPICall(for error: Error, completionHandler: WeatherJSONCompletionHandler) {
        completionHandler(Result.failure(error))
    }
}
