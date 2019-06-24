//
//  WeatherListHandlerProtocol.swift
//  Weather
//
//  Created by Nischal Hada on 6/24/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol WeatherListHandlerProtocol {
    func fetchCityInfo(withfileName fileName: String, completion: @escaping ((Result<[CityListModel], ErrorResult>) -> Void))
    func fetchWeatherInfo(withCityIDs cityIDs: String, completion: @escaping ((Result<[WeatherInformation], ErrorResult>) -> Void))
    func fetchWeatherInfo(withCityID cityID: String, completion: @escaping ((Result<WeatherInformation, ErrorResult>) -> Void))
}
