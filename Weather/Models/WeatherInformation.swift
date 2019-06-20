//
//  WeatherInformation.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct WeatherInformation: Codable {
    var main: Main?
    var name: String?
    var id: Int?
    var coord: Coord?
    var weather: [Weather]?
    var clouds: Clouds?
    var dt: Int?
    var base: String?
    var sys: Sys?
    var cod: Int?
    var visibility: Int?
    var wind: Wind?
}
