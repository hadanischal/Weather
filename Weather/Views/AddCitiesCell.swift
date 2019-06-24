//
//  AddCitiesCell.swift
//  Weather
//
//  Created by Nischal Hada on 6/21/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class AddCitiesCell: UITableViewCell {
    @IBOutlet weak var labelCityName: UILabel!
    @IBOutlet weak var labelCityId: UILabel!

    var addCitiesModel: CityListModel? {
        didSet {
            guard let data = addCitiesModel else {
                return
            }
            labelCityName.text = data.name
            labelCityId.text = "\(data.id ?? 0)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
