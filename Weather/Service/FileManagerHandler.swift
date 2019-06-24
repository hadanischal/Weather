//
//  FileManagerHandler.swift
//  Weather
//
//  Created by Nischal Hada on 6/23/19.
//  Copyright © 2019 NischalHada. All rights reserved.
//

import UIKit

struct FileManagerResource<T> {
    let fileName: String
    let parse: (Data) -> T?
}

class FileManagerHandler: FileManagerHandlerProtocol {
    init() {}

        func load<T>(resource: FileManagerResource<T>, completion: @escaping (T?) -> Void) {
             if let url = Bundle.main.url(forResource: resource.fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    completion(resource.parse(data))
                  } catch (let error) {
                    print("error:\(error)")
                    completion(nil)
                }
            }
    }
}
