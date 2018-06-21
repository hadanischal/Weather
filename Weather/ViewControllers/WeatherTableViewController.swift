//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController,AddCitiesDelegate {
    func finishPassing(_ data: AddCitiesModel){
        print("passing up")
        print(data)
    }
    
    //MARK:- Segues
    enum Segues: String {
        case showDetail = "toDetailViewController"
        case saveAddCity = "toAddCitiesViewController"
    }
    var arrayWeather : [WeatherInformation] = []
    fileprivate var activityIndicator : ActivityIndicator! = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupUIRefreshControl()
        self.setUpDataSource()
    }
    
    func setUpUI(){
        self.title = "Weather Information"
        self.tableView.backgroundColor = ThemeColor.tableViewBackgroundColor
        self.view.backgroundColor = ThemeColor.viewBackgroundColor
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(actionAddCities))
    }
    
    func setupUIRefreshControl() {
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(actionPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @IBAction func actionAddCities(_ sender: AnyObject){
        // self.performSegue(withIdentifier: Segues.saveAddCity.rawValue, sender: nil)
        let controller: AddCitiesViewController = storyboard!.instantiateViewController(withIdentifier: "AddCitiesViewController") as! AddCitiesViewController
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true, completion: nil)
        
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
                self.activityIndicator.stop()
            }
        }
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
        switch Segues(rawValue: segue.identifier!) {
        case .showDetail?:
            let indexPath = (sender as! IndexPath);
            if let controller = segue.destination as? WeatherDetailViewController {
                controller.weatherData = self.arrayWeather[indexPath.row]
            }
        case .saveAddCity?:
            break
        case .none:
            break
        }
        
    }
}
