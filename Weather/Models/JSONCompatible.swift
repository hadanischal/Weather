//
//  JSONCompatible.swift
//  Weather
//
//  Created by Nischal Hada on 6/18/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol JSONCompatible {
    init?(json: [String: Any]?)
    init()
    init?(data: Data?)
    func jsonDictionary(useOriginalJsonKey: Bool) -> [String: Any]
}
