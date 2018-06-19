//
//  AddCitiesViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/19/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class AddCitiesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    func setUpUI(){
        self.title = "Add City"
        self.view.backgroundColor = ThemeColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(actionCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(actionSave))
    }
    
    @IBAction func actionCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionSave(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
