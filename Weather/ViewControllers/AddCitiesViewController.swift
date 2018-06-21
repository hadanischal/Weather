//
//  AddCitiesViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class AddCitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    fileprivate var activityIndicator : ActivityIndicator! = ActivityIndicator()
    fileprivate let readJson: FileManagerReadJson! = FileManagerReadJson()
    var dataSource:[AddCitiesModel] = [AddCitiesModel]()
    var filteredData:[AddCitiesModel] = [AddCitiesModel]()
    var searchActive : Bool = false
    
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
        self.view.backgroundColor = ThemeColor.white
        self.tableView.backgroundColor = ThemeColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(actionCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(actionSave))
    }
    
    @IBAction func actionCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSave(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpDataSource(){
        self.activityIndicator.start()
        readJson.handellJSONSerialization(input: "citylist") { (Result) in
            self.activityIndicator.stop()
            for json in Result!{
                let result = AddCitiesModel.init(json: json as? [String : Any])
                self.dataSource.append(result!)
            }
            self.filteredData = self.dataSource
            self.tableView.reloadData()
            self.activityIndicator.stop()
            
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
            let delayTime = DispatchTime.now() + Double(Int64(1.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.filteredData.removeAll()
                let filterServices = self.dataSource.filter({$0.name?.lowercased().range(of: strText.lowercased()) != nil})
                print(filterServices)
                self.filteredData =  filterServices
                self.searchActive = true;
                self.tableView.reloadData()
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

extension AddCitiesViewController:UITabBarDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
