//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    var arrayWeather : [WeatherInformation] = []
    fileprivate var activityIndicator : ActivityIndicator! = ActivityIndicator()
    let segueIdentifier = "toDetailViewController"
    let segueIdentifierAddCity = "toAddCitiesViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupUIRefreshControl()
        self.setUpDataSource()
    }
    
    func setUpUI(){
        self.title = "Weather Information"
        self.tableView.backgroundColor = ThemeColor.white
        self.view.backgroundColor = ThemeColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(setupAddCitiesControl))
    }
    
    func setupUIRefreshControl() {
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(actionPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func setupAddCitiesControl() {
        self.performSegue(withIdentifier: segueIdentifierAddCity, sender: nil)
    }
    
    func setUpDataSource(){
        self.activityIndicator.start()
        self.getWeatherInformationOfCityID(url: APIManager.sydneyURL) {
            self.getWeatherInformationOfCityID(url: APIManager.melbourneURL, successBlock: {
                self.getWeatherInformationOfCityID(url: APIManager.brisbaneURL, successBlock: {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.activityIndicator.stop()
                    }
                    
                })
            })
        }
    }
    
    func getWeatherInformationOfCityID(url :URL, successBlock:@escaping () -> Void){
        WeatherJSONClient.fetchWeather(url: url){ (result) in
            switch result {
            case .success(let json):
                print(json)
                let result = WeatherInformation.init(json: json)
                self.arrayWeather.append(result!)
                successBlock()
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func showAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionPullRefresh() {
        self.setUpDataSource()
        self.refreshControl?.endRefreshing()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayWeather.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInformationCell", for: indexPath) as! WeatherInformationCell
        cell.configureCellWithData(arrayWeather[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetailViewController", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let indexPath = (sender as! IndexPath);
            if let controller = segue.destination as? WeatherDetailViewController {
                controller.weatherData = self.arrayWeather[indexPath.row]
            }
        }
    }
}
