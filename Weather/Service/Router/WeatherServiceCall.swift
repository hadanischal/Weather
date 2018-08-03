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
    var arrayWeather: [WeatherInformation] = []
    var manager:NetworkManager = NetworkManager()
    
    func fetchWeatherServiceCall_byGroup(_ list : [StartWeatherModel], successBlock:@escaping () -> Void){
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
                    if let list = self.parseJSON(data: json){
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
    
    func fetchWeatherServiceCall_byCityId(_ data : StartWeatherModel, successBlock:@escaping () -> Void){
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
    
    func parseJSON(data : [String:Any]) -> [WeatherInformation]?{
        guard let list = data["list"] as? [AnyObject]else{
            return nil
        }
        var arrayWeather: [WeatherInformation] = []
        for properties in list{
            let result = WeatherInformation.init(json: properties as? [String : Any])
            arrayWeather.append(result!)
        }
        return arrayWeather
    }
}

