//
//  AddCitiesModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/20/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//  Provide a way to add more cities
//

import Foundation

struct AddCitiesModel: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
}
