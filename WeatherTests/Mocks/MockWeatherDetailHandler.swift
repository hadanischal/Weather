//
//  MockWeatherDetailHandler.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockWeatherDetailHandler: WeatherDetailHandlerProtocol {
    var weatherData: [DetailModel]?

    func fetchWeatherInfo(withWeatherInfo data: WeatherInformation, completion: @escaping ((Result<[[DetailModel]], ErrorResult>) -> Void)) {
        if let result = weatherData {
            completion(.success([result]))
        } else {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
