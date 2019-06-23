//
//  CityListHandlerProtocol.swift
//  Weather
//
//  Created by Nischal Hada on 6/23/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol CityListHandlerProtocol {
    func load<T>(resource: CityResource<T>, completion: @escaping (T?) -> Void)
}
