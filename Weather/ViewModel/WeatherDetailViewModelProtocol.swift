//
//  WeatherDetailViewModelProtocol.swift
//  Weather
//
//  Created by Nischal Hada on 6/24/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol WeatherDetailViewModelProtocol {
    var dataSource: Dynamic<[[DetailModel]]> { get }
    var onErrorHandling: ((ErrorResult?) -> Void)? { get set }
}
