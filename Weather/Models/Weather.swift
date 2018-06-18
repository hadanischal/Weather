//
//  Weather.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct Weather: JSONCompatible {
    var main: String
    var icon: String
    var description: String
    var id: Int

    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        main = json["main"] as? String ?? ""
        icon = json["icon"] as? String ?? ""
        description = json["description"] as? String ?? ""
        id = json["id"] as? Int ?? 0
    }
    
    init() {
        self.init(json: [:])!
    }
    
    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }
    
    init(main: String, icon: String, description: String, id: Int) {
        self.main = main
        self.icon = icon
        self.description = description
        self.id = id
    }
    
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["main"] = main
        dict["icon"] = icon
        dict["description"] = description
        dict["id"] = id
        return dict
    }
    
}



