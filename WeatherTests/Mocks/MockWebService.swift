//
//  MockWebService.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockWebService: WebServiceProtocol {
    var weatherData: Data?

    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
        if let data = weatherData {
            completion(resource.parse(data))
        }else {
            completion(nil)
        }
    }
}
