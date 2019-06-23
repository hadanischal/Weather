//
//  ProgressHUD.swift
//  Weather
//
//  Created by Nischal Hada on 6/22/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol Progressing {
    func ShowSVProgressHUD_White()
    func ShowSVProgressHUD_Black()
    func DismissSVProgressHUD()
}

class ProgressHUD {
}

extension ProgressHUD: Progressing {

    func ShowSVProgressHUD_White() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        SVProgressHUD.show()
    }

    func ShowSVProgressHUD_Black() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor( UIColor.black.withAlphaComponent(0.4))
        SVProgressHUD.setForegroundColor( ThemeColor.white)
        SVProgressHUD.setRingThickness( 1.0)
    }

    func DismissSVProgressHUD() {
        UIApplication.shared.endIgnoringInteractionEvents()
        SVProgressHUD.dismiss()
    }
}
