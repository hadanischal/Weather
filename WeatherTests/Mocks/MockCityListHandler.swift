//
//  MockCityListHandler.swift
//  WeatherTests
//
//  Created by Nischal Hada on 7/20/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
@testable import Weather

class MockCityListHandler: CityListHandlerProtocol {
    var cityListData: [CityListModel]? = [CityListModel]()
    
    func fetchCityInfo(withfileName fileName: String, completion: @escaping ((Result<[CityListModel], ErrorResult>) -> Void)) {
        if let result = cityListData {
            completion(.success(result))
        } else {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
