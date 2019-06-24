//
//  WeatherDetailHandler.swift
//  Weather
//
//  Created by Nischal Hada on 6/24/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class WeatherDetailHandler: WeatherDetailHandlerProtocol {

    init() {
    }
    ///TODO : enhance this logic
    func fetchWeatherInfo(withWeatherInfo data: WeatherInformation, completion: @escaping ((Result<[[DetailModel]], ErrorResult>) -> Void)) {
        let header: [DetailModel] = [
            DetailModel(title: data.weather?[0].description ?? "", description: "\(data.main?.temp ?? 0)°", image: WeatherImageProvider().provideValue(data.weather?[0].main ?? ""))
        ]

        let dateSunrise = NSDate(timeIntervalSince1970: TimeInterval(data.sys?.sunrise ?? 0))
        let dateSunset = NSDate(timeIntervalSince1970: TimeInterval(data.sys?.sunset ?? 0))

        let body: [DetailModel] = [
            DetailModel(title: "Humidity", description: "\(data.main?.humidity ?? 0)%", image: "Humidity"),
            DetailModel(title: "Temperature", description: "\(data.main?.temp_max ?? 0)° : \(data.main?.temp_min ?? 0)°", image: "Temperature"),
            DetailModel(title: "WindSpeed", description: "\(data.wind?.speed ?? 0)m/s", image: "WindSpeed"),
            DetailModel(title: "Visibility", description: "\(data.visibility ?? 0)", image: "Visibility"),
            DetailModel(title: "Sunrise", description: StringFromDate().getTimeStringFromDate(date: dateSunrise as Date), image: "Sunrise"),
            DetailModel(title: "Sunset", description: StringFromDate().getTimeStringFromDate(date: dateSunset as Date), image: "Sunset")
        ]
        completion(.success([header, body]))
    }
}
