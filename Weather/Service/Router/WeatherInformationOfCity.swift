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
    var weatherData: WeatherDataStore { return WeatherDataStore() }
    var arrayWeather: [WeatherInformation] = []
    
    func getWeatherInformationOfCityArray(_ list : [StartWeatherModel], successBlock:@escaping () -> Void){
        self.arrayWeather.removeAll()
        let arrayId = list.map { String($0.id!) }
        let stringId = arrayId.joined(separator: ",")
        self.getWeatherInformationBulkDownloading(url: APIManager.weatherGroupAPIURL(stringId), successBlock: {
            DispatchQueue.main.async {
                successBlock()
            }
        })
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
    
    func getWeatherInformationBulkDownloading(url :URL, successBlock:@escaping () -> Void){
        WeatherJSONClient.fetchWeather(url: url){ (result) in
            switch result {
            case .success(let json):
                print(json)
                if let list = self.weatherData.getBulkWeatherInformation(data: json){
                    self.arrayWeather = list
                }
                successBlock()
            case .failure(let error):
                print(error.localizedDescription)
                successBlock()
                
            }
        }
    }
}
