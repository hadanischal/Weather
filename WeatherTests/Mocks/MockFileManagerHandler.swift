//
//  MockFileManagerHandler.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockFileManagerHandler: FileManagerHandlerProtocol {
    var cityData: Data?

    func load<T>(resource: FileManagerResource<T>, completion: @escaping (T?) -> Void) {
        if let data = cityData {
            completion(resource.parse(data))
        } else {
            completion(nil)
        }
    }
}
