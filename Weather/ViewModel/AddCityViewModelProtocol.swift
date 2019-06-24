//
//  AddCityViewModelProtocol.swift
//  Weather
//
//  Created by Nischal Hada on 6/24/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation

protocol AddCityViewModelProtocol {
    var cityListModel: Dynamic<[CityListModel]> { get }
    var onErrorHandling: ((ErrorResult?) -> Void)? { get set }
    var isFinished: Dynamic<Bool> { get }
}
