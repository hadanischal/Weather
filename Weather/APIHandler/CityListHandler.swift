//
//  CityListHandler.swift
//  Weather
//
//  Created by Nischal Hada on 6/24/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class CityListHandler: CityListHandlerProtocol {

    private let fileManagerHandler: FileManagerHandlerProtocol!

    init(withFileManagerHandler fileManagerHandler: FileManagerHandlerProtocol = FileManagerHandler()) {
        self.fileManagerHandler = fileManagerHandler
    }

    func fetchCityInfo(withfileName fileName: String, completion: @escaping ((Result<[CityListModel], ErrorResult>) -> Void)) {
        let cityResource = FileManagerResource<[CityListModel]>(fileName: fileName) { data in
            let cityListModel = try? JSONDecoder().decode([CityListModel].self, from: data)
            return cityListModel
        }
        self.fileManagerHandler.load(resource: cityResource) { response in
            if let result = response {
                completion(.success(result))
            } else {
                completion(.failure(.parser(string: "Error while parsing json data")))
            }
        }
    }
}
