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

    func getCity(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let bundle = Bundle(for: type(of: self))
            if let path = bundle.path(forResource: "citylist", ofType: "json") {
                if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: path)) {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([AddCitiesModel].self, from: data )
                        self.dataCity = result
                        completion()
                    } catch let error {
                        print(error.localizedDescription)
                        completion()
                    }
                }
            }
        }
    }

}
