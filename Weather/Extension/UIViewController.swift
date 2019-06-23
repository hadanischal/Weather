//
//  UIViewController.swift
//  Weather
//
//  Created by Nischal Hada on 6/20/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) -> Void in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
