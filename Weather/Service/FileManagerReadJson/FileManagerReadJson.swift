//
//  FileManagerReadJson.swift
//  Weather
//
//  Created by Nischal Hada on 6/21/18.
//  Copyright © 2018 NischalHada. All rights reserved.
//

import Foundation

protocol FileManaging {
    func handellJSONSerialization(input: String, completion: @escaping ([AnyObject]?) -> Void)
}

final class FileManagerReadJson:FileManaging{
    func handellJSONSerialization(input: String, completion: @escaping ([AnyObject]?) -> Void){
        let data = FileManager.readJson(input)
        do {
            if let list = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyObject]{
                completion(list)
            } else {
                completion([])
                print("Error while parsing json data")
            }
        } catch {
            completion([])
            print("Error while parsing json data")
        }
    }
    
}


