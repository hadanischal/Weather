//
//  MockWebService.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockWebService: WebService {
    override func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
    }
}
