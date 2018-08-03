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
    fileprivate let readJson: FileManagerReadJson! = FileManagerReadJson()
    var dataCity: [AddCitiesModel] = []
    fileprivate let jsonName = "citylist"

    func getCity(completion: @escaping () -> Void){
        DispatchQueue.main.async {
            let bundle = Bundle(for: type(of: self))
            if let path = bundle.path(forResource: self.jsonName, ofType: "json") {
                if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
                    let parsedData = self.parseJSON(data: data)
                    guard let data = parsedData else{
                        return
                    }
                    if data.count != 0{
                        for json in data{
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

