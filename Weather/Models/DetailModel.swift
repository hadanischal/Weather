//
//  DetailModel.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

struct DetailModel{
    let title: String?
    let image: String?
    init(title: String, image: String?){
        self.title = title
        self.image = image
    }
}

extension DetailModel{
    static func setupSideBaArray(_ dataSource : WeatherInformation) -> [[DetailModel]] {
        let header: [DetailModel] = [
            DetailModel(title: dataSource.weather[0].description, image: "imageMyCompanies"),
            ]
        let body: [DetailModel] = [
            DetailModel(title: "Dashboard", image: "imageDashboard"),
            DetailModel(title: "Projects", image: "imageProjects"),
            DetailModel(title: "Work Orders", image: "imageWorkOrders"),
            DetailModel(title: "My Companies", image: "imageMyCompanies"),
            DetailModel(title: "Logout", image: "imageLogout")
        ]
        return [header,body]
    }
}
