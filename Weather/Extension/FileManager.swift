//
//  FileManager.swift
//  Weather
//
//  Created by Nischal Hada on 6/20/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation


extension FileManager {
    static func readJson(_ fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
            }
        }
        return nil
    }
}
