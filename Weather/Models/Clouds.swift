//
//  Clouds.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct Clouds: JSONCompatible {
    var all: Int
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        all = json["all"] as? Int ?? 0
    }
    
    init() {
        self.init(json: [:])!
    }
    
    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }
    
    init(all: Int) {
        self.all = all
    }
    
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["all"] = all
        return dict
    }
}
