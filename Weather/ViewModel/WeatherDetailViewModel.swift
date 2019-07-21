//
//  WeatherDetailViewModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/24/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class WeatherDetailViewModel: WeatherDetailViewModelProtocol {

    let dataSource: Dynamic<[[DetailModel]]>
    var onErrorHandling: ((ErrorResult?) -> Void)?

    private let weatherDetailHandler: WeatherDetailHandlerProtocol!
    private let weatherInfo: WeatherInformation?

    init(withCityListHandler weatherDetailHandler: WeatherDetailHandlerProtocol = WeatherDetailHandler(), withWeatherInformation weatherInfo: WeatherInformation?) {
        self.weatherDetailHandler = weatherDetailHandler
        self.weatherInfo = weatherInfo

        self.dataSource = Dynamic([[]])
        self.fetchWeatherInfo()
    }

    private func fetchWeatherInfo() {
        if let weatherInfo = self.weatherInfo {
            self.weatherDetailHandler.fetchWeatherInfo(withWeatherInfo: weatherInfo) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let info):
                        self?.dataSource.value = info
                    case .failure(let error):
                        self?.onErrorHandling?(error)
                    }
                }
            }
        } else {
            self.onErrorHandling?(ErrorResult.custom(string: "WeatherInformation is missing"))
        }
    }
}
