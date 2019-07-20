//
//  MockWeatherListHandler.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockWeatherListHandler: WeatherListHandlerProtocol {
    var cityListData: [CityListModel]? = [CityListModel]()
    var weatherListData: [WeatherInformation]? = [WeatherInformation]()
    var weatherData: WeatherInformation?
    
    func fetchCityInfo(withfileName fileName: String, completion: @escaping ((Result<[CityListModel], ErrorResult>) -> Void)) {
        if let result = cityListData {
            completion(.success(result))
        } else {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    func fetchWeatherInfo(withCityIDs cityIDs: String, completion: @escaping ((Result<[WeatherInformation], ErrorResult>) -> Void)) {
        if let result = weatherListData {
            completion(.success(result))
        } else {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    func fetchWeatherInfo(withCityID cityID: String, completion: @escaping ((Result<WeatherInformation, ErrorResult>) -> Void)) {
        if let result = weatherData {
            completion(.success(result))
        } else {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
