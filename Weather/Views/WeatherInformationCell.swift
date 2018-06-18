//
//  WeatherInformationCell.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class WeatherInformationCell: UITableViewCell {
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCellWithData(dataObject : WeatherInformation){
        labelCityName.text = dataObject.name
        labelCityTemperature.text = "\(dataObject.main.temp) °C"
    }
}
