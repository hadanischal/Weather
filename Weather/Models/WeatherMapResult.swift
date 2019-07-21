//
//  WeatherMapResult.swift
//  Weather
//
//  Created by Nischal Hada on 6/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct WeatherMapResult: Codable {
    var cnt: Int?
    var list: [WeatherInformation]?
}
