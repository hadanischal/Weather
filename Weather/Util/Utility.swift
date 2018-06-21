//
//  Utility.swift
//  Weather
//
//  Created by Nischal Hada on 6/21/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    //Show Loading indicator
    static var activityBaseView:UIView=UIView()
    
    static func showLoader() {
        activityBaseView.frame=(UIApplication.shared.delegate?.window??.frame)!
        activityBaseView.backgroundColor=UIColor.white
        activityBaseView.alpha=0.6;
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.center = activityBaseView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityBaseView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.delegate?.window??.addSubview(activityBaseView)
    }
    
    static func hideLoader()
    {
        activityBaseView.removeFromSuperview()
    }
}
