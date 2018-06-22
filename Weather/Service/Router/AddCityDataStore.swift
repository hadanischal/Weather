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
    
    func getCity(completion: @escaping () -> Void){
        DispatchQueue.main.async {
            self.readJson.handellJSONSerialization(input: "citylist") { (Result) in
                DispatchQueue.main.async {
                    if Result?.count != 0{
                        for json in Result!{
                            let result = AddCitiesModel.init(json: json as? [String : Any])
                            self.dataCity.append(result!)
                        }
                        completion()
                    }
                }
            }
        }
    }
}

