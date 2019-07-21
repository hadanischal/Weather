//
//  SettingsViewModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/25/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import Foundation
///TODO: Need to implement settings
enum Unit: String, CaseIterable {

    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {

    var displayName: String {
        get {
            switch(self) {
            case .celsius:
                return "Celsius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }

}

struct SettingsViewModel {

    let units = Unit.allCases

}
