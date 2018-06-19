//
//  WeatherDetailOthersCell.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class WeatherDetailOthersCell: UICollectionViewCell {
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var detailLabel: UILabel?
    @IBOutlet var weatherImage: UIImageView?
    
    func configureCellWithData(dataObject : WeatherInformation){
        titleLabel?.text = dataObject.name
        detailLabel?.text = "\(dataObject.main.temp) °C"
    }
}
