//
//  CityListModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/23/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

struct CityListModel: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}
