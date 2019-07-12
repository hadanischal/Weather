//
//  MockFileManagerHandler.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/12/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockFileManagerHandler: FileManagerHandler {
    override func load<T>(resource: FileManagerResource<T>, completion: @escaping (T?) -> Void) {
    }
}
