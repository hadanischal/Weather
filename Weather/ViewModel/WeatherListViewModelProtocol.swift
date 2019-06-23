//
//  WeatherListViewModelProtocol.swift
//  Weather
//
//  Created by Nischal Hada on 6/23/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol WeatherListViewModelProtocol {
    var weatherList: Dynamic<[WeatherInformation]> { get }
    var isFinished: Dynamic<Bool> { get }
    func pullToRefresh()
}
