//
//  WeatherDataStore.swift
//  Weather
//
//  Created by Nischal Hada on 6/22/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol WeatherData {
    func getBulkWeatherInformation(data : [String:Any]) -> [WeatherInformation]
}

class WeatherDataStore:WeatherData {
    func getBulkWeatherInformation(data : [String:Any]) -> [WeatherInformation]{
        let list = data["list"] as! [AnyObject]
        var arrayWeather: [WeatherInformation] = []
        for properties in list{
            let result = WeatherInformation.init(json: properties as? [String : Any])
            arrayWeather.append(result!)
        }
        return arrayWeather
    }
}
