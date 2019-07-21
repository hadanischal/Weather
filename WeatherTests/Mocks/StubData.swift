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

    func stubCityData() -> Data {
        guard let data = self.readJson(forResource: "testCityList") else {
            XCTAssert(false, "Can't get data from testCityList.json")
            return Data()
        }
        return data
    }

    func stubWeatherData() -> Data {
        guard let data = self.readJson(forResource: "testWeatherData") else {
            XCTAssert(false, "Can't get data from testWeatherData.json")
            return Data()
        }
        return data
    }

    func stubWeatherListData() -> Data {
        guard let data = self.readJson(forResource: "testWeatherList") else {
            XCTAssert(false, "Can't get data from \("testWeatherList").json")
            return Data()
        }
        return data
    }

    func stubCity() -> [CityListModel] {

        guard let data = self.readJson(forResource: "testCityList") else {
            XCTAssert(false, "Can't get data from testCityList.json")
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
        if
            let result = try? decoder.decode(WeatherMapResult.self, from: data),
            let weatherList = result.list
        {
            return weatherList
        } else {
            XCTAssert(false, "Unable to parse WeatherInformation results")
            return [WeatherInformation.empty]
        }
    }

    func stubDetailModel() -> [[DetailModel]] {
        let detail = [
            [
                DetailModel(title: "Humidity", description: "Humidity description", image: "Humidity image"),
                DetailModel(title: "Temperature", description: "Temperature description", image: "Temperature image")
            ],
            [
                DetailModel(title: "WindSpeed", description: "WindSpeed description", image: "WindSpeed image"),
                DetailModel(title: "Visibility", description: "Visibility description", image: "Visibility image")
            ]

        ]
        return detail
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
