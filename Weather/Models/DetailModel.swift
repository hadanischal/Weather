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
            DetailModel(title:data.weather?[0].description ?? "", description:"\(data.main?.temp ?? 0)°", image:         WeatherImageProvider().provideValue(data.weather?[0].main ?? ""))
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
        return [header,body]
    }
    

}
