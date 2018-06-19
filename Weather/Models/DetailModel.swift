//
//  DetailModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct DetailModel{
    let title: String?
    let description: String?
    let image: String?
    init(title: String,
         description: String, image: String?){
        self.title = title
        self.description = description
        self.image = image
    }
}

extension DetailModel{
    static func setupDetailModel(_ data : WeatherInformation) -> [[DetailModel]] {
        let header: [DetailModel] = [
            DetailModel(title:data.weather[0].description, description:"\(data.main.temp)°", image:         WeatherImageProvider().provideValue(data.weather[0].main))
            ]
        
        let dateSunrise = NSDate(timeIntervalSince1970: TimeInterval(data.sys.sunrise))
        let dateSunset = NSDate(timeIntervalSince1970: TimeInterval(data.sys.sunset))

        let body: [DetailModel] = [
            DetailModel(title: "Humidity", description: "\(data.main.humidity)%", image: "Humidity"),
            DetailModel(title: "Temperature", description: "\(data.main.temp_max)° : \(data.main.temp_min)°", image: "Temperature"),
            DetailModel(title: "WindSpeed", description: "\(data.wind.speed)m/s", image: "WindSpeed"),
            DetailModel(title: "Visibility", description: "\(data.visibility)", image: "Visibility"),
            DetailModel(title: "Sunrise", description: getTimeStringFromDate(date: dateSunrise as Date), image: "Sunrise"),
            DetailModel(title: "Sunset", description: getTimeStringFromDate(date: dateSunset as Date), image: "Sunset")
        ]
        return [header,body]
    }
    
    static func getTimeStringFromDate(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let dataString = dateFormatter.string(from: date)
        return dataString
    }
}
