//
//  WeatherInformation.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct WeatherInformation {
    var main: Main
    var name: String
    var id: Int
    var coord: Coord
    var weather: [Weather]
    var clouds: Clouds
    var dt: Int
    var base: String
    var sys: Sys
    var cod: Int
    var visibility: Int
    var wind: Wind
    
    init?(json: [String: Any]?) {
        guard let json = json else {return nil}
        main = Main(json: json["main"] as? [String: Any]) ?? Main()
        name = json["name"] as? String ?? ""
        id = json["id"] as? Int ?? 0
        coord = Coord(json: json["coord"] as? [String: Any]) ?? Coord()
        weather = (json["weather"] as? [[String: Any]] ?? []).compactMap{Weather(json: $0)}
        clouds = Clouds(json: json["clouds"] as? [String: Any]) ?? Clouds()
        dt = json["dt"] as? Int ?? 0
        base = json["base"] as? String ?? ""
        sys = Sys(json: json["sys"] as? [String: Any]) ?? Sys()
        cod = json["cod"] as? Int ?? 0
        visibility = json["visibility"] as? Int ?? 0
        wind = Wind(json: json["wind"] as? [String: Any]) ?? Wind()
    }
    
    init() {
        self.init(json: [:])!
    }
    
    init?(data: Data?) {
        guard let data = data else {return nil}
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {return nil}
        self.init(json: json)
    }
    
    init(main: Main, name: String, id: Int, coord: Coord, weather: [Weather], clouds: Clouds, dt: Int, base: String, sys: Sys, cod: Int, visibility: Int, wind: Wind) {
        self.main = main
        self.name = name
        self.id = id
        self.coord = coord
        self.weather = weather
        self.clouds = clouds
        self.dt = dt
        self.base = base
        self.sys = sys
        self.cod = cod
        self.visibility = visibility
        self.wind = wind
    }
    
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["main"] = main.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["name"] = name
        dict["id"] = id
        dict["coord"] = coord.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["weather"] = weather.map{$0.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)}
        dict["clouds"] = clouds.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["dt"] = dt
        dict["base"] = base
        dict["sys"] = sys.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        dict["cod"] = cod
        dict["visibility"] = visibility
        dict["wind"] = wind.jsonDictionary(useOriginalJsonKey: useOriginalJsonKey)
        return dict
    }
}
