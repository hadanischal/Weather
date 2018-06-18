//
//  Coord.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct Coord: JSONCompatible {
    var lon: Double
    var lat: Double
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        lon = json["lon"] as? Double ?? 0.0
        lat = json["lat"] as? Double ?? 0.0
    }
    
    init() {
        self.init(json: [:])!
    }
    
    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
    
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["lon"] = lon
        dict["lat"] = lat
        return dict
    }
}

