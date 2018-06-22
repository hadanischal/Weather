//
//  WeatherDetailViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    enum Sections: Int {
        case headers, body
    }
    @IBOutlet var collectionView: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    var weatherData  : WeatherInformation!
    var dataSource = [[DetailModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.dataSource = DetailModel.setupDetailModel(weatherData)
        self.setupCollectionView()
    }
    
    func setupUI() {
        self.navigationItem.title = weatherData.name
    }
    
    func setupCollectionView() -> Void{
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        self.collectionView.collectionViewLayout = layout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0 //0.0
        self.collectionView.backgroundColor = ThemeColor.tableViewBackgroundColor
        self.collectionView.showsHorizontalScrollIndicator = false
    }
}

extension WeatherDetailViewController :UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Sections(rawValue: (indexPath as NSIndexPath).section)! {
        case .headers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailTemperatureCell", for: indexPath) as! WeatherDetailTemperatureCell
            cell.configureCellWithData(self.dataSource[indexPath.section][indexPath.row])
            return cell
        case .body:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailOthersCell", for: indexPath) as! WeatherDetailOthersCell
            cell.configureCellWithData(self.dataSource[indexPath.section][indexPath.row])
            return cell
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension WeatherDetailViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(" didSelectItemAt indexPath")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let itemsPerRow:CGFloat  = CGFloat(self.dataSource[indexPath.section].count) / 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
 
        switch Sections(rawValue: indexPath.section)! {
        case .headers:
            return CGSize(width: view.frame.width, height: 160)
        case .body:
            return CGSize(width: widthPerItem, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
}
