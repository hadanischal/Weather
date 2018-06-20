//
//  AddCitiesModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/20/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct AddCitiesModel{
    let title: String?
    let description: String?
    let image: String?
    init(title: String,
         description: String, image: String?){
        self.title = title
        self.description = description
        self.image = image
    }
}
