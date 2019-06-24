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
    var onErrorHandling: ((ErrorResult?) -> Void)? { get set }

    var isFinished: Dynamic<Bool> { get }
    func pullToRefresh()
    func fetchWeatherInfo(byCity city: CityListModel)

}
