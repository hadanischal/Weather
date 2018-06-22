//
//  AddCitiesViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//  Provide a way to add more cities using another modal view controller which includes a search functionality to find a city by name or location.
//

import UIKit

protocol AddCitiesDelegate {
    func methodAddCities(_ data: StartWeatherModel)
}

class AddCitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    fileprivate let readJson: FileManagerReadJson! = FileManagerReadJson()
    var dataSource:[AddCitiesModel] = [AddCitiesModel]()
    var filteredData:[AddCitiesModel] = [AddCitiesModel]()
    var selectedCity:AddCitiesModel? //= AddCitiesModel()
    var delegate: AddCitiesDelegate?
    var searchActive : Bool = false
    var progressHUD: ProgressHUD { return ProgressHUD() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setUpDataSource()
    }
    
    func setUpUI(){
        self.title = "Add City"
        self.view.backgroundColor = ThemeColor.viewBackgroundColor
        self.tableView.backgroundColor = ThemeColor.tableViewBackgroundColor
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationController?.presentThemeNavigationBar()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(actionCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(actionSave))
    }
    
    @IBAction func actionCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSave(_ sender: AnyObject) {
        if self.selectedCity != nil {
            dismiss(animated: true, completion: {
                let data =  StartWeatherModel(id: (self.selectedCity?.id)!, name: (self.selectedCity?.name)!)
                self.delegate?.methodAddCities(data)
            })
        }else{
            self.showAlert(title: "Error", message:"Please select the city first")
        }
    }
    
    func setUpDataSource(){
        if AddCityDataStore.sharedInstance.dataCity.count != 0{
            self.progressHUD.ShowSVProgressHUD_Black()
            self.dataSource =  AddCityDataStore.sharedInstance.dataCity
            self.filteredData = self.dataSource
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.progressHUD.DismissSVProgressHUD()
            }
        }else{
            self.progressHUD.ShowSVProgressHUD_Black()
            DispatchQueue.main.async {
                AddCityDataStore.sharedInstance.getCity(completion: {
                    DispatchQueue.main.async {
                        self.dataSource =  AddCityDataStore.sharedInstance.dataCity
                        self.filteredData = self.dataSource
                        self.tableView.reloadData()
                        self.progressHUD.DismissSVProgressHUD()
                    }
                })
            }
        }
    }
  }

// MARK: - UISearchBarDelegate Setup
extension AddCitiesViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        // searchActive = false;
        self.searchBarSearchBegin(searchBar)
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true;
    }
    
    func searchBarSearchBegin(_ searchBar: UISearchBar) {
        let strText:String =  searchBar.text!.replacingOccurrences(of: " ", with: "")
        if (strText ).isEmpty {
            searchActive = false;
        }else{
            self.progressHUD.ShowSVProgressHUD_Black()

            DispatchQueue.main.async {
                self.filteredData.removeAll()
                let foundItems = self.dataSource.filter { (($0.name?.range(of: strText)) != nil) || $0.id == Int(strText) }
                print(foundItems)
                self.filteredData =  foundItems
                self.searchActive = true;
                self.tableView.reloadData()
                self.progressHUD.DismissSVProgressHUD()
            }
        }
    }
}


extension AddCitiesViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCitiesCell", for: indexPath) as! AddCitiesCell
        cell.configureCellWithData(filteredData[indexPath.row])
        return cell
    }
}

extension AddCitiesViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCity = filteredData[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
