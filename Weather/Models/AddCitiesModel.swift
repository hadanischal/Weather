//
//  AddCitiesModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/20/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//  Provide a way to add more cities
//

import Foundation

struct AddCitiesModel{
    let id: Int?
    let name: String?
    let coord: Coord
    let country: String
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        id = json["id"] as? Int ?? 0
        name = json["name"] as? String ?? ""
        coord = Coord(json: json["coord"] as? [String: Any]) ?? Coord()
        country = json["country"] as? String ?? ""
    }
    
    init() {
        self.init(json: [:])!
    }
    
    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }
    
    init(id: Int, name: String, coord: Coord, country: String) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
    }
    
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["id"] = id
        dict["name"] = name
        dict["coord"] = coord.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["country"] = country
        return dict
    }
}
