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
        case settings = "toSettingsViewController"
    }
    var arrayWeather: [WeatherInformation] = [WeatherInformation]()
    var progressHUD: ProgressHUD { return ProgressHUD() }

    var viewModel: WeatherListViewModelProtocol = WeatherListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setupViewModel()
        self.setupUIRefreshControl()
    }

    func setupViewModel() {
        self.viewModel.weatherList.bindAndFire { [weak self] list in
            DispatchQueue.main.async {
                self?.arrayWeather = list
                self?.tableView.reloadData()
            }
        }
        self.viewModel.isFinished.bindAndFire { [weak self] isTrue in
            if isTrue {
                self?.progressHUD.DismissSVProgressHUD()
            } else {
                self?.progressHUD.ShowSVProgressHUD_Black()
            }
        }
        self.viewModel.onErrorHandling = { [weak self] error in
            self?.showAlert(title: "An error occured", message: error?.localizedDescription)
        }
    }

    func setUpUI() {
        self.title = "Weather Information"
        self.tableView.backgroundColor = UIColor.tableViewBackgroundColor
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    func setupUIRefreshControl() {
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(actionPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    // MARK: - Add Cities Methods
    func methodAddCities(_ data: CityListModel) {
        viewModel.fetchWeatherInfo(byCity: data)
    }

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
        if
            let identifier = segue.identifier,
            let segueValue = Segues(rawValue: identifier)
        {

            switch segueValue {
            case .showDetail:
                self.prepareSegueForWeatherDetailVC(for: segue, sender: sender)

            case .saveAddCity:
                self.prepareSegueForAddWeatherVC(segue: segue)
                break

            case .settings:
                self.prepareSegueForSettingsVC(segue: segue)
                break
            }

        } else {
            fatalError("segue not found")
        }
    }
}

extension WeatherTableViewController {

    private func prepareSegueForWeatherDetailVC(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let indexPath = sender as? IndexPath,
            let controller = segue.destination as? WeatherDetailViewController
        {
            controller.weatherData = self.arrayWeather[indexPath.row]
        }
    }

    private func prepareSegueForSettingsVC(segue: UIStoryboardSegue) {
        if
            let navigationController = segue.destination as? UINavigationController,
            let SettingsVc = navigationController.viewControllers.first as? SettingsViewController
        {
//            SettingsVc.delegate = self
        } else {
            fatalError("NavigationController not found")
        }
    }

    private func prepareSegueForAddWeatherVC(segue: UIStoryboardSegue) {
        if
            let navigationController = segue.destination as? UINavigationController,
            let CitiesVC = navigationController.viewControllers.first as? AddCitiesViewController
        {
            CitiesVC.delegate = self
        } else {
            fatalError("NavigationController not found")
        }
    }
}
