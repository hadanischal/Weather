//
//  WeatherTableViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController, AddCitiesDelegate {

    // MARK: - Segues
    enum Segues: String {
        case showDetail = "toDetailViewController"
        case saveAddCity = "toAddCitiesViewController"
    }
    // MARK: - Information of Sydney, Melbourne and Brisbaneand their ID at begining as start.
    var dataSource: [StartWeatherModel] = StartWeatherModel.setupStartingModelData()
    var arrayWeather: [WeatherInformation] = [WeatherInformation]()
    var progressHUD: ProgressHUD { return ProgressHUD() }
    
    var viewModel: WeatherListViewModelProtocol = WeatherListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
//        self.setupUIRefreshControl()
//        self.setUpDataSource()
        self.viewModel.weatherList.bindAndFire { [weak self] list in
            DispatchQueue.main.async {
                self?.arrayWeather = list
                self?.tableView.reloadData()
            }
        }
        
        self.viewModel.isFinished.bindAndFire { [weak self] isTrue in
            if isTrue {
                self?.progressHUD.DismissSVProgressHUD()
            }else{
                self?.progressHUD.ShowSVProgressHUD_Black()
            }
        }
    }

    func setUpUI() {
        self.title = "Weather Information"
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColor
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(actionAddCities))
    }

    func setupUIRefreshControl() {
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(actionPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }



    @IBAction func actionAddCities(_ sender: AnyObject) {
        let controller: AddCitiesViewController = storyboard!.instantiateViewController(withIdentifier: "AddCitiesViewController") as! AddCitiesViewController
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.present(navigationController, animated: true, completion: nil)
    }

    // MARK: - Add Cities Methods
    func methodAddCities(_ data: StartWeatherModel) {
        let foundItems = self.arrayWeather.filter { $0.name == data.name && $0.id == data.id }
        if foundItems.count == 0 {
            self.dataSource.append(data)
            self.progressHUD.ShowSVProgressHUD_Black()
            WeatherServiceCall.sharedInstance.fetchWeatherServiceCall_byCityId(data) {
                print("success")
                self.arrayWeather = WeatherServiceCall.sharedInstance.arrayWeather
                self.tableView.reloadData()
                self.progressHUD.DismissSVProgressHUD()
            }
        } else {
            self.showAlert(title: "Error", message: "City already added")
        }
    }
    ///TODO: remove this code
//    func setUpDataSource() {
//        self.progressHUD.ShowSVProgressHUD_Black()
//        WeatherServiceCall.sharedInstance.fetchWeatherServiceCall_byGroup(dataSource) {
//            print("success")
//            self.arrayWeather = WeatherServiceCall.sharedInstance.arrayWeather
//            self.tableView.reloadData()
//            self.progressHUD.DismissSVProgressHUD()
//        }
//    }
    @objc func actionPullRefresh() {
        self.viewModel.pullToRefresh()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInformationCell", for: indexPath) as? WeatherInformationCell else {
            fatalError("WeatherCell not found")
        }
        cell.WeatherModel = arrayWeather[indexPath.row]
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
            let indexPath = (sender as! IndexPath)
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
