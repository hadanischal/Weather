//
//  StringFromDate.swift
//  Weather
//
//  Created by Nischal Hada on 6/22/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol StringFromDateProtocal{
    func getTimeStringFromDate(date : Date) -> String
}

class StringFromDate: StringFromDateProtocal {
    func getTimeStringFromDate(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let dataString = dateFormatter.string(from: date)
        return dataString
    }
}
