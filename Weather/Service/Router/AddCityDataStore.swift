//
//  AddCityDataStore.swift
//  Weather
//
//  Created by Nischal Hada on 6/22/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

final class AddCityDataStore {
    
    static let sharedInstance = AddCityDataStore()
    fileprivate init() {}
    var dataCity = [AddCitiesModel]()
    
    func getCity(completion: @escaping () -> Void){
        DispatchQueue.main.async {
            let bundle = Bundle(for: type(of: self))
            if let path = bundle.path(forResource: "citylist", ofType: "json") {
                if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
                    guard let list = self.parseJSON(data: data) else {return}
                    if list.count != 0{
                        for json in list{
                            let result = AddCitiesModel.init(json: json)
                            self.dataCity.append(result!)
                        }
                        completion()
                    }
                }
            }
        }
    }
    
    
    func parseJSON(data : Data) -> [[String:Any]]? {
        let cache: [[String:Any]]? = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
        return cache
    }
    
}

