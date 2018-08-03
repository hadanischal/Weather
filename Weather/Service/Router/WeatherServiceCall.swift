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
    var weatherData: WeatherDataStore { return WeatherDataStore() }
    var arrayWeather: [WeatherInformation] = []
    var manager:NetworkManager = NetworkManager()
    
    func getWeatherInformationOfCityArray(_ list : [StartWeatherModel], successBlock:@escaping () -> Void){
        self.arrayWeather.removeAll()
        let arrayId = list.map { String($0.id!) }
        let stringId = arrayId.joined(separator: ",")
        
        manager.request(method: .get, url: APIManager.weatherGroupAPIURL(stringId), parameters: nil) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let json):
                    print(json)
                    guard let json = json as? [String : Any] else {
                        //let error = NetworkingError.badJSON
                        return
                    }
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
    
    func getWeatherInformationOfCityID(_ data : StartWeatherModel, successBlock:@escaping () -> Void){
        manager.request(method: .get, url: APIManager.weatherAPIURL(data.id!), parameters: nil) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    print(json)
                    guard let json = json as? [String : Any] else {
                        //let error = NetworkingError.badJSON
                        return
                    }
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
    
    
}

