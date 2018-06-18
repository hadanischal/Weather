//
//  Wind.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct Wind: JSONCompatible {
    var deg: Int
    var speed: Double
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        deg = json["deg"] as? Int ?? 0
        speed = json["speed"] as? Double ?? 0.0
    }
    
    init() {
        self.init(json: [:])!
    }
    
    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }
    
    init(deg: Int, speed: Double) {
        self.deg = deg
        self.speed = speed
    }
    
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["deg"] = deg
        dict["speed"] = speed
        return dict
    }
}
