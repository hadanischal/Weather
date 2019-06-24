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
    var onErrorHandling: ((ErrorResult?) -> Void)?

    private var cityList: [CityListModel]!
    private let weatherListHandler: WeatherListHandlerProtocol!
    private var periodicTimer: Timer!
    private let timePeriod = 60 * 10 //10

    init(withWeatherListHandler weatherListHandler: WeatherListHandlerProtocol = WeatherListHandler()) {
        self.weatherListHandler = weatherListHandler
        self.weatherList = Dynamic([])
        self.isFinished = Dynamic(false)

        periodicTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timePeriod), target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        self.fetchCityInfo()
    }

    // MARK: - Weather automatically updated periodically
    @objc private func runTimedCode(_ sender: AnyObject) {
        // periodicTimer.invalidate()
        self.fetchCityInfo()
    }

    func pullToRefresh() {
        self.fetchCityInfo()
    }

    private func fetchCityInfo() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.weatherListHandler.fetchCityInfo(withfileName: "StartCity") { [weak self] result in
                switch result {
                case .success(let list) :
                    self?.cityList = list
                    self?.fetchWeatherInfo(byCityList: list)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    self?.isFinished.value = true
                    self?.onErrorHandling?(error)
                    break
                }
            }
        }
    }

    private func fetchWeatherInfo(byCityList cityList: [CityListModel]) {
        let arrayId = cityList.map { String($0.id!) }
        let cityIDs = arrayId.joined(separator: ",")

        self.weatherListHandler.fetchWeatherInfo(withCityIDs: cityIDs) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFinished.value = true
                switch result {
                case .success(let list) :
                    self?.weatherList.value = list
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    self?.onErrorHandling?(error)
                    break
                }
            }
        }
    }
    //relay.accept(relay.value + ["Item 2"])

    func fetchWeatherInfo(byCity city: CityListModel) {
        let results = self.cityList.filter { $0.name == city.name && $0.id == city.id }
        let isExists = results.isEmpty == false
        if
            let cityId = city.id,
            !isExists
        {
            self.isFinished.value = false
            self.weatherListHandler.fetchWeatherInfo(withCityID: "\(cityId)") { [weak self] result in
                var list = self?.weatherList.value
                DispatchQueue.main.async {
                    self?.isFinished.value = true
                    switch result {
                    case .success(let info) :
                        list?.append(info)
                        self?.weatherList.value = list ?? [info]
                        break
                    case .failure(let error) :
                        print("Parser error \(error)")
                        self?.onErrorHandling?(error)
                        break
                    }
                }
            }
        }
    }
}
