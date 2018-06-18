//
//  WeatherJSONClient.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

enum WeatherJSONClient: WeatherJSONProtocol {
    static func fetchWeather(url :URL, _ completionHandler: @escaping WeatherJSONCompletionHandler) {
        NetworkManager().request(method: .get, url: url, parameters: nil) { (result) in
            self.handle(result: result, completionHandler: completionHandler)
        }
    }
    
//    static func fetchWeather(page: Int = 1, _ completionHandler: @escaping WeatherJSONCompletionHandler) {
//        NetworkManager().request(method: .get, url: APIManager.sydneyURL, parameters: nil) { (result) in
//            self.handle(result: result, completionHandler: completionHandler)
//        }
//    }
}
