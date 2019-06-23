//
//  CityListHandler.swift
//  Weather
//
//  Created by Nischal Hada on 6/23/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

struct CityResource<T> {
    let fileName: String
    let parse: (Data) -> T?
}

class CityListHandler: CityListHandlerProtocol {
    init() {}

        func load<T>(resource: CityResource<T>, completion: @escaping (T?) -> Void) {
             if let url = Bundle.main.url(forResource: resource.fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    completion(resource.parse(data))
                  } catch (let error) {
                    print("error:\(error)")
                    completion(nil)
                }
            }
    }
}
