//
//  NetworkingError.swift
//  Weather
//
//  Created by Nischal Hada on 8/3/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

enum NetworkingError: LocalizedError {
    case badJSON
    public var errorDescription: String? {
        switch self {
        case .badJSON:
            return NSLocalizedString("The data from the server came back in a way we couldn't use", comment: "")
        }
    }
}
