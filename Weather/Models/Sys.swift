//
//  Sys.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct Sys: Codable {
    var sunset: Int?
    var sunrise: Int?
    var message: Double?
    var id: Int?
    var type: Int?
    var country: String?
}
