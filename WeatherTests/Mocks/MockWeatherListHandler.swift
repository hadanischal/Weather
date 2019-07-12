//
//  MockWeatherListHandler.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockWeatherListHandler: WeatherListHandler {
    convenience init() {
        self.init(withFileManagerHandler: MockFileManagerHandler(), withWebservice: MockWebService())
    }
    var invokedFetchCityInfo = false
    var invokedFetchCityInfoCount = 0
    var invokedFetchCityInfoParameters: (fileName: String, Void)?
    var invokedFetchCityInfoParametersList = [(fileName: String, Void)]()
    var stubbedFetchCityInfoCompletionResult: (Result<[CityListModel], ErrorResult>, Void)?
    override func fetchCityInfo(withfileName fileName: String, completion: @escaping ((Result<[CityListModel], ErrorResult>) -> Void)) {
        invokedFetchCityInfo = true
        invokedFetchCityInfoCount += 1
        invokedFetchCityInfoParameters = (fileName, ())
        invokedFetchCityInfoParametersList.append((fileName, ()))
        if let result = stubbedFetchCityInfoCompletionResult {
            completion(result.0)
        }
    }
    var invokedFetchWeatherInfoWithCityIDs = false
    var invokedFetchWeatherInfoWithCityIDsCount = 0
    var invokedFetchWeatherInfoWithCityIDsParameters: (cityIDs: String, Void)?
    var invokedFetchWeatherInfoWithCityIDsParametersList = [(cityIDs: String, Void)]()
    var stubbedFetchWeatherInfoWithCityIDsCompletionResult: (Result<[WeatherInformation], ErrorResult>, Void)?
    override func fetchWeatherInfo(withCityIDs cityIDs: String, completion: @escaping ((Result<[WeatherInformation], ErrorResult>) -> Void)) {
        invokedFetchWeatherInfoWithCityIDs = true
        invokedFetchWeatherInfoWithCityIDsCount += 1
        invokedFetchWeatherInfoWithCityIDsParameters = (cityIDs, ())
        invokedFetchWeatherInfoWithCityIDsParametersList.append((cityIDs, ()))
        if let result = stubbedFetchWeatherInfoWithCityIDsCompletionResult {
            completion(result.0)
        }
    }
    var invokedFetchWeatherInfoWithCityID = false
    var invokedFetchWeatherInfoWithCityIDCount = 0
    var invokedFetchWeatherInfoWithCityIDParameters: (cityID: String, Void)?
    var invokedFetchWeatherInfoWithCityIDParametersList = [(cityID: String, Void)]()
    var stubbedFetchWeatherInfoWithCityIDCompletionResult: (Result<WeatherInformation, ErrorResult>, Void)?
    override func fetchWeatherInfo(withCityID cityID: String, completion: @escaping ((Result<WeatherInformation, ErrorResult>) -> Void)) {
        invokedFetchWeatherInfoWithCityID = true
        invokedFetchWeatherInfoWithCityIDCount += 1
        invokedFetchWeatherInfoWithCityIDParameters = (cityID, ())
        invokedFetchWeatherInfoWithCityIDParametersList.append((cityID, ()))
        if let result = stubbedFetchWeatherInfoWithCityIDCompletionResult {
            completion(result.0)
        }
    }
}
