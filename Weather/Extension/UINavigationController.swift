//
//  UINavigationController.swift
//  Weather
//
//  Created by Nischal Hada on 6/21/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

extension UINavigationController{
    public func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
        setNavigationBarHidden(false, animated:true)
    }
    public func presentThemeNavigationBar() {
        setNavigationBarHidden(false, animated:false)
        navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        
        //        navigationBar.barTintColor = NavigationBar.barTintColor
        //        navigationBar.titleTextAttributes = NavigationBar.titleTextAttributes
        //        navigationBar.tintColor = NavigationBar.TintColor
        
        
    }
}
