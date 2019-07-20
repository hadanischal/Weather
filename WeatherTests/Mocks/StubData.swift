//
//  StubData.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import XCTest
@testable import Weather

class StubData {
    static let shared = StubData()
    
    init() {
        
    }
    func stubCity() -> [CityListModel] {
        
        guard let data = self.readJson(forResource: "testCityList") else {
            XCTAssert(false, "Can't get data from Person.json")
            return [CityListModel.empty]
        }
        
        let decoder = JSONDecoder()
        if let result = try? decoder.decode([CityListModel].self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse CityListModel results")
            return [CityListModel.empty]
        }
    }
    
    func stubWeather() -> [WeatherInformation] {
        
        guard let data = self.readJson(forResource: "testWeatherList") else {
            XCTAssert(false, "Can't get data from json")
            return [WeatherInformation.empty]
        }
        
        let decoder = JSONDecoder()
        if let result = try? decoder.decode([WeatherInformation].self, from: data) {
            return result
        } else {
            XCTAssert(false, "Unable to parse WeatherInformation results")
            return [WeatherInformation.empty]
        }
    }
}

extension StubData {
    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTAssert(false, "Missing file: \(fileName).json")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch (_) {
            XCTAssert(false, "unable to read json")
            return nil
        }
    }
}
