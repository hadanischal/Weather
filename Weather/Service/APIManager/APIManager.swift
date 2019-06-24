//
//  APIManager.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

enum Method: String {
    case sydneyId = "2147714"
    case melbourneId = "4163971"
    case brisbaneId = "2174003"
}

struct APIManager {
    private static let baseURLString = "http://api.openweathermap.org/data/2.5/"
    private static let apiKey = "5a230a39a381b73ad15ca01075d63117"
    private static let weatherUnit = "weather?"
    private static let groupUnit = "group?"

    private static let Metric = "metric"

    static var sydneyURL: URL {
        return weatherAPIURL(method: .sydneyId)
    }

    static var melbourneURL: URL {
        return weatherAPIURL(method: .melbourneId)
    }

    static var brisbaneURL: URL {
        return weatherAPIURL(method: .brisbaneId)
    }

    // MARK: - General Methods
    private static func weatherAPIURL(method: Method) -> URL {
        let weatherInfoUrl =  baseURLString + "id=\(method.rawValue)&units=\(weatherUnit)&APPID=\(apiKey)"
        let finalURL = URL(string: weatherInfoUrl)!
        return finalURL
    }
    public static func weatherAPIURL(_ cityID: String) -> URL {
        let weatherInfoUrl =  baseURLString + weatherUnit + "id=\(cityID)&units=\(Metric)&APPID=\(apiKey)"
        let finalURL = URL(string: weatherInfoUrl)!
        return finalURL
    }
   // https://samples.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric&appid=b6907d289e10d714a6e88b30761fae22
    public static func weatherGroupAPIURL(_ cityID: String) -> URL {
        let weatherInfoUrl =  baseURLString + groupUnit + "id=\(cityID)&units=\(Metric)&APPID=\(apiKey)"
        let finalURL = URL(string: weatherInfoUrl)!
        return finalURL
    }
}
