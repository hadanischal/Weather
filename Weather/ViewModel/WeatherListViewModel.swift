//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/23/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class WeatherListViewModel: WeatherListViewModelProtocol {
    let weatherList: Dynamic<[WeatherInformation]>
    let isFinished: Dynamic<Bool>

    private let cityListHandler: CityListHandlerProtocol!
    private let webService: WebServiceProtocol!
    private var periodicTimer: Timer!
    private let timePeriod = 60 * 10 //10

    init(withCityListHandler cityListHandler: CityListHandlerProtocol = CityListHandler(), withWebservice webService: WebServiceProtocol = WebService()) {
        self.cityListHandler = cityListHandler
        self.webService = webService
        self.weatherList = Dynamic([])
        self.isFinished = Dynamic(false)
        
        periodicTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timePeriod), target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.getCityInfo()
    }

    // MARK: - Weather automatically updated periodically
    @objc private func runTimedCode(_ sender: AnyObject) {
        // periodicTimer.invalidate()
        self.getCityInfo()
    }
    
    func pullToRefresh(){
        self.getCityInfo()
    }
}

extension WeatherListViewModel {
    
    private func getCityInfo() {
        let cityResource = CityResource<[CityListModel]>(fileName: "StartCity") { data in
            let cityListModel = try? JSONDecoder().decode([CityListModel].self, from: data)
            return cityListModel
        }

        self.cityListHandler.load(resource: cityResource) { [weak self] response in
            if let cityList = response {
                let arrayId = cityList.map { String($0.id!) }
                let stringIds = arrayId.joined(separator: ",")
                self?.getWeatherInfo(byCityIDs: stringIds)
            }
        }
    }

    private func getWeatherInfo(byCityIDs cityIDs: String) {
        let weatherURL = APIManager.weatherGroupAPIURL(cityIDs)
        let cityResource = Resource<WeatherMapResult>(url: weatherURL) { data in
            let cityListModel = try? JSONDecoder().decode(WeatherMapResult.self, from: data)
            return cityListModel
        }

        self.webService.load(resource: cityResource) { [weak self] response in
            if
                let result = response,
                let weatherInfo = result.list
            {
                self?.weatherList.value = weatherInfo
                self?.isFinished.value = true
            }
        }
    }

    private func getWeatherInfo(byCityID cityID: String) {
        let weatherURL = APIManager.weatherGroupAPIURL(cityID)
        let cityResource = Resource<WeatherInformation>(url: weatherURL) { data in
            let cityListModel = try? JSONDecoder().decode(WeatherInformation.self, from: data)
            return cityListModel
        }

        self.webService.load(resource: cityResource) { response in
        }
    }
}
