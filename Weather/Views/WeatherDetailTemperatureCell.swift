//
//  WeatherDetailTemperatureCell.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class WeatherDetailTemperatureCell: UICollectionViewCell {
    @IBOutlet weak var bagroundView: UIView!
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var detailLabel: UILabel?
    @IBOutlet var weatherImage: UIImageView?

    var detailModel: DetailModel? {
        didSet {
            guard let data = detailModel else {
                return
            }
            titleLabel?.text = data.title
            detailLabel?.text = data.description
            weatherImage?.image = UIImage(named: data.image!)
        }
    }
}
