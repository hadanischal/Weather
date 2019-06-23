//
//  WeatherServiceCall.swift
//  Weather
//
//  Created by Nischal Hada on 8/3/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

class WeatherServiceCall {
    static let sharedInstance = WeatherServiceCall()
    var arrayWeather = [WeatherInformation]()
    var manager: NetworkManager = NetworkManager()

    func fetchWeatherServiceCall_byGroup(_ list: [StartWeatherModel], successBlock:@escaping () -> Void) {
        self.arrayWeather.removeAll()
        let arrayId = list.map { String($0.id!) }
        let stringId = arrayId.joined(separator: ",")

        manager.responseData(method: .get, url: APIManager.weatherGroupAPIURL(stringId), parameters: nil) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    //print(data)
                    do {
                        let decoder = JSONDecoder()
                        let json = try decoder.decode(WeatherMapResult.self, from: data )
                        if let list = json.list {
                            self.arrayWeather = list
                        }
                        successBlock()
                    } catch let error {
                        print(error.localizedDescription)
                        successBlock()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    successBlock()
                }
            }
        }
    }

    func fetchWeatherServiceCall_byCityId(_ data: StartWeatherModel, successBlock:@escaping () -> Void) {
        manager.responseData(method: .get, url: APIManager.weatherAPIURL(data.id!), parameters: nil) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    //print(data)
                    do {
                        let decoder = JSONDecoder()
                        let json = try decoder.decode(WeatherInformation.self, from: data )
                        self.arrayWeather.append(json)
                        successBlock()
                    } catch let error {
                        print(error.localizedDescription)
                        successBlock()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    successBlock()
                }
            }
        }
    }
}
