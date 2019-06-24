//
//  AddCityViewModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/23/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

class AddCityViewModel: AddCityViewModelProtocol {

    let cityListModel: Dynamic<[CityListModel]>
    let isFinished: Dynamic<Bool>
    var onErrorHandling: ((ErrorResult?) -> Void)?

    private let cityListHandler: CityListHandlerProtocol!

    init(withCityListHandler cityListHandler: CityListHandlerProtocol = CityListHandler()) {
        self.cityListHandler = cityListHandler

        self.cityListModel = Dynamic([])
        self.isFinished = Dynamic(false)
        self.fetchCityInfo()
    }

    private func fetchCityInfo() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.cityListHandler.fetchCityInfo(withfileName: "citylist") { [weak self] result in
                DispatchQueue.main.async {
                    self?.isFinished.value = true
                    switch result {
                    case .success(let list) :
                        self?.cityListModel.value = list
                        break
                    case .failure(let error) :
                        print("Parser error \(error)")
                        self?.onErrorHandling?(error)
                        break
                    }
                }
            }
        }
    }
}
