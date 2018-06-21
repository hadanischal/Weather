//
//  StartWeatherModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/22/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct StartWeatherModel{
    let id: Int?
    let name: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension StartWeatherModel{
    static func setupStartingModelData() -> [StartWeatherModel] {
        let body: [StartWeatherModel] = [
            StartWeatherModel(id: 2147714, name: "Sydney"),
            StartWeatherModel(id: 4163971, name: "Melbourne"),
            StartWeatherModel(id: 2174003, name: "Brisbane"),
            ]
        return body
    }
}
extension StartWeatherModel : Comparable {

    static func == (lhs: StartWeatherModel, rhs: StartWeatherModel) -> Bool {
        return (lhs.id, lhs.name) ==
            (rhs.id, rhs.name)
    }
    
    static func < (lhs: StartWeatherModel, rhs: StartWeatherModel) -> Bool {
        return (lhs.id)! < (rhs.id)!
    }
}
