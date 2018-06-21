//
//  WeatherInformationOfCity.swift
//  Weather
//
//  Created by Nischal Hada on 6/22/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

final class  WeatherInformationOfCity {
    static let sharedInstance = WeatherInformationOfCity()
    var arrayWeather: [WeatherInformation] = []
    
    func getWeatherInformationOfCityArray(_ list : [StartWeatherModel], successBlock:@escaping () -> Void){
        self.arrayWeather.removeAll()
        let backgroundQueue = DispatchQueue(label: "requests")
        let semaphore = DispatchSemaphore(value: 1)
        backgroundQueue.async {
            for properties in list{
                self.getWeatherInformationOfCityID(url: APIManager.weatherAPIURL(properties.id!), successBlock: {
                    semaphore.signal()
                    DispatchQueue.main.async {
                        /* if properties.id == list.last?.id && properties.name == list.last?.name {
                         successBlock()
                         }*/
                        if self.arrayWeather.count == list.count{
                            successBlock()
                        }
                    }
                })
            }
        }
    }
    
    func addCityWeatherInformation(_ data : StartWeatherModel, successBlock:@escaping () -> Void){
        self.getWeatherInformationOfCityID(url: APIManager.weatherAPIURL(data.id!), successBlock: {
            DispatchQueue.main.async {
                successBlock()
            }
        })
    }
    func getWeatherInformationOfCityID(url :URL, successBlock:@escaping () -> Void){
        WeatherJSONClient.fetchWeather(url: url){ (result) in
            switch result {
            case .success(let json):
                print(json)
                let result = WeatherInformation.init(json: json)
                self.arrayWeather.append(result!)
                successBlock()
            case .failure(let error):
                print(error.localizedDescription)
                successBlock()
                
            }
        }
    }
}
