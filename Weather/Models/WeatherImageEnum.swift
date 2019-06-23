//
//  WeatherImageEnum.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

enum  WeatherImageEnum: String {
    case Clouds, Clear, Rain, Squall, Drizzle, Snow, Thunderstorm

    var create: String {
        switch self {
        case .Clouds:
            return "CloudySky"
        case .Clear:
            return "ClearSky"
        case .Rain:
            return "RainSky"
        case .Squall:
            return "SquallSky"
        case .Drizzle:
            return "DrizzleSky"
        case .Snow:
            return "SnowSky"
        case .Thunderstorm:
            return "ThunderSky"
        }
    }
}

struct WeatherImageProvider {
    func provideValue(_ weather: String) -> String {
        if let imageValue = WeatherImageEnum(rawValue: weather) {
            let colorSelected = imageValue.create
            return colorSelected
        } else {
            print("handle invalid weather error")
            return WeatherImageEnum.Clear.rawValue
        }
    }
}
